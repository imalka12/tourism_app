import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/models/activity.dart';

// const API_URL = 'http://192.168.8.101:8000/api';
// const API_URL = 'http://10.0.2.2:8000/api';
const API_URL = 'http://192.168.1.238:8000/api';
final dio = Dio();

/// get tour types from the backend API
Future<List<Activity>> getActivities() async {
  try {
    Response response = await dio.get('$API_URL/get-activities',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      var data = response.data as List;
      var activities = data.map((e) => Activity.fromJson(e)).toList();
      return activities;
    } else {
      // Handle other status codes as needed
      return <Activity>[];
    }
  } catch (e) {
    print('Error fetching categories: $e');
    return <Activity>[]; // Return an empty list in case of an error
  }
}

Future<Map<String, bool>> saveActivities(
    Map<String, bool> selectedActivities) async {
  // save the type preferences to hive box and return the map
  Box activitiesBox = await Hive.openBox('activities');

  print('Selected activities: $selectedActivities');

  // iterate over the typePrefs map and save each entry to the box
  selectedActivities.forEach((key, value) {
    activitiesBox.put(key, value);
  });

  return selectedActivities;
}

Map<String, dynamic> roomSelection = {
  'roomCount': 1,
  'roomType': 'Single',
  'mealPlan': 'BB',
};
