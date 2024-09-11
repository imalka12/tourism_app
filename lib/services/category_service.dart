import 'package:dio/dio.dart';
import 'package:tourism_app/models/category.dart';

const API_URL = 'http://192.168.8.101:8000/api';
// const API_URL = 'http://10.0.2.2:8000/api';
// const API_URL = 'http://192.168.1.238:8000/api';
final dio = Dio();

/// get tour types from the backend API
Future<List<Category>> getCategories() async {
  try {
    Response response = await dio.get('$API_URL/get-tour-types',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }));

    if (response.statusCode == 200) {
      var data = response.data as List;
      var categories = data.map((e) => Category.fromJson(e)).toList();
      return categories;
    } else {
      // Handle other status codes as needed
      return <Category>[];
    }
  } catch (e) {
    print('Error fetching categories: $e');
    return <Category>[]; // Return an empty list in case of an error
  }
}
