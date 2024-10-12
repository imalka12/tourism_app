import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/common/constants.dart';
import 'package:tourism_app/models/hotel.dart';

final dio = Dio();

/// get tour types from the backend API
Future<List<Hotel>> getHotels() async {
  try {
    Response response = await dio.get('$apiUrl/get-hotels',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      List<Hotel> hotels = [];

      var hotelData = response.data['data'];
      for (var hotel in hotelData) {
        hotels.add(Hotel.fromJson(hotel));
      }

      return hotels;
    } else {
      // Handle other status codes as needed
      return <Hotel>[];
    }
  } catch (e) {
    print('Error fetching hotels: $e');
    return <Hotel>[]; // Return an empty list in case of an error
  }
}

Future<Map<String, String>> getHotelTypes() async {
  try {
    Response response = await dio.get('$apiUrl/get-hotel-types',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      Map<String, String> hotelTypes = Map<String, String>.from(response.data);
      print(hotelTypes);
      return hotelTypes;
    } else {
      return <String, String>{};
    }
  } catch (e) {
    return <String, String>{}; // Return an empty map in case of an error
  }
}

// save hotel type selection to hotel_type_prefs hive box
Future<String?> saveHotelTypePrefs(String? hotelType) async {
  // save the type preferences to hive box and return the map
  Box typePrefsBox = Hive.box('hotel_type_prefs');
  typePrefsBox.put('hotel_type', hotelType);

  return hotelType;
}

// get selected hotel type from hotel_type_prefs hive box
Future<String?> getHotelTypePrefs() async {
  Box typePrefsBox = Hive.box('hotel_type_prefs');
  String? hotelType = typePrefsBox.get('hotel_type', defaultValue: '');

  return hotelType;
}
