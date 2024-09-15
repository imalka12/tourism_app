import 'package:dio/dio.dart';
import 'package:tourism_app/common/constants.dart';
import 'package:tourism_app/models/vehicle.dart';

final dio = Dio();

/// get tour types from the backend API
Future<List<Vehicle>> getVehicles() async {
  try {
    Response response = await dio.get('$API_URL/get-vehicles',
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
