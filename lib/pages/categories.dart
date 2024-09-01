import 'package:flutter/material.dart';
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
  double preferencePercentage = 0.75; // 75%

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
                MaterialPageRoute(builder: (context) => DateRangePage()));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 32),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
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
      body: Padding(
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
                FutureBuilder(
                  future: getCategories(),
                  builder: (context, snapshot) {
                    // show a loader as a placeholder if the connectin state is not done
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }

                    if (snapshot.hasError) {
                      print('error is ' + snapshot.error.toString());
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
                            onSliderChange: (value) {
                              print('${cat.title} - value: $value');
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16.0,
                          );
                        },
                        itemCount: data!.length);
                  },
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Activities()));
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
    );
  }
}
