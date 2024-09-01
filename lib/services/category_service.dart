import 'dart:convert';

import 'package:tourism_app/models/category.dart';
import 'package:http/http.dart' as http;

/// get tour types from the backend API
Future<List<Category>> getCategories() async {
  var response = await http
      .get(Uri.http('localhost:8000/api/get-tour-types', ''), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  });

  if (response.statusCode == 200) {
    var data = json.decode(response.body)['data'] as List;
    return data.map((e) => Category.fromJson(e)) as List<Category>;
  }

  return <Category>[];
}
