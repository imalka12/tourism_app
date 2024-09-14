import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/common/tour_type_slider.dart';
import 'package:tourism_app/models/category.dart';
import 'package:tourism_app/pages/activities.dart';
import 'package:tourism_app/pages/date_range_page.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/services/category_service.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future types;
  final double defaultPercentage = 0.75; // 75%
  Map<String, double> typePreferences = {};

  @override
  void initState() {
    super.initState();

    types = getCategories();

    loadSaveTypePrefsFromHiveBox().then((value) {
      if (typePreferences.isEmpty) {
        // get each value from the types list and set it to the typePreferences map
        types.then((value) {
          value.forEach((element) {
            typePreferences[element.title!] = defaultPercentage;
          });
        });
      }
    });
  }

  Future<void> loadSaveTypePrefsFromHiveBox() async {
    // load the saved preferences from the hive box
    Box box = await Hive.openBox('type_prefs');
    // and set it to the typePreferences map
    setState(() {
      typePreferences = Map<String, double>.from(box.toMap());
    });
  }

  void onSliderChange(String label, double value) {
    setState(() {
      typePreferences[label] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan your trip',
          style: TextStyle(fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const DateRangePage()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 32),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: UserProfile(),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What type of holidays you prefer?',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 600,
                    child: FutureBuilder(
                      future: types,
                      builder: (context, snapshot) {
                        // show a loader as a placeholder if the connection state is not done
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Text('Failed to load tour types');
                        }

                        if (snapshot.hasData && snapshot.data == null) {
                          return const Text('No tour types available.');
                        }

                        List<Category>? data = snapshot.data;

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            // return the actual widget
                            Category cat = data[index];

                            return TourTypeSlider(
                              label: cat.title!,
                              initialValue: typePreferences[cat.title!] ?? 50,
                              onSliderChange: (value) {
                                onSliderChange(cat.title!, value);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey[300],
                              thickness: 1.0,
                            );
                          },
                          itemCount: data!.length,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      saveCategories(typePreferences).then(
                        (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Activities(),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
