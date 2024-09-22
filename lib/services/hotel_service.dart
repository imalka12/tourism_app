import 'package:dio/dio.dart';
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

      print('Hotels: $hotels');

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

List<String> getHotelTypes() {
  List<String> types = [];

  Dio()
      .get('$apiUrl/get-hotel-types',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }))
      .then((response) {
    if (response.statusCode == 200) {
      var hotelTypesData = response;

      return hotelTypesData;
    } else {
      print('Error: Status code ${response.statusCode}');
    }
  }).catchError((e) {
    print('Error fetching hotel types: $e');
  });

  return types;
}
