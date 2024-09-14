import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/pages/categories.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/pages/vehicles.dart';
import 'package:tourism_app/services/activity_service.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

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
                MaterialPageRoute(builder: (context) => const Categories()));
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
      body: const PreferencesScreen(),
    );
  }
}

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  late Future activitiesList;
  Map<String, bool> activities = {};

  @override
  void initState() {
    super.initState();

    activitiesList = getActivities();

    loadSavedActivitiesFromHiveBox().then((value) {
      if (activities.isEmpty) {
        activitiesList.then((data) {
          for (var activity in data) {
            activities[activity.title!] = false;
          }
        });
      }
    });
  }

  Future<void> loadSavedActivitiesFromHiveBox() async {
    // load the saved preferences from the hive box
    Box box = await Hive.openBox('activities');
    // and set it to the typePreferences map
    setState(() {
      activities = Map<String, bool>.from(box.toMap());
    });
  }

  void onActivitySelected(String label, bool value) {
    setState(() {
      activities[label] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What type of activities you like?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder(
                future: activitiesList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Text('Failed to load activities');
                  }

                  var data = snapshot.data;
                  return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      return ActivityCheckBox(
                        title: data[index].title!,
                        isChecked: activities[data[index].title!] ?? false,
                        onChanged: (bool value) {
                          onActivitySelected(data[index].title!, value);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    saveActivities(activities).then(
                      (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Vehicles()));
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
    );
  }
}

class ActivityCheckBox extends StatelessWidget {
  final String title;
  final bool isChecked;
  final Function(bool) onChanged;
  const ActivityCheckBox(
      {super.key,
      required this.title,
      required this.isChecked,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: isChecked,
      onChanged: (bool? value) {
        onChanged(value!);
      },
    );
  }
}
