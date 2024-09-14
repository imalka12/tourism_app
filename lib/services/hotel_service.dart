import 'package:dio/dio.dart';
import 'package:tourism_app/models/hotel.dart';

// const API_URL = 'http://192.168.8.101:8000/api';
// const API_URL = 'http://10.0.2.2:8000/api';
const API_URL = 'http://192.168.1.238:8000/api';
final dio = Dio();

/// get tour types from the backend API
Future<List<Hotel>> getHotels() async {
  try {
    Response response = await dio.get('$API_URL/get-hotels',
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
