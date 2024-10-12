import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/common/constants.dart';
import 'package:tourism_app/models/vehicle.dart';

final dio = Dio();

/// get tour types from the backend API
Future<List<Vehicle>> getVehicles() async {
  try {
    Response response = await dio.get('$apiUrl/get-vehicles',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      var data = response.data as List;
      var vehicles = data.map((e) => Vehicle.fromJson(e)).toList();
      return vehicles;
    } else {
      // Handle other status codes as needed
      return <Vehicle>[];
    }
  } catch (e) {
    print('Error fetching categories: $e');
    return <Vehicle>[]; // Return an empty list in case of an error
  }
}

// save vehicle object to the vehicles box
Future<void> saveVehicle(Vehicle vehicle) async {
  var box = Hive.box<Vehicle>('vehicles');
  await box.put('vehicle', vehicle);
}

// get selected vehicle
Future<Vehicle?> getSelectedVehicle() async {
  var box = Hive.box<Vehicle>('vehicles');
  return box.get('vehicle');
}
