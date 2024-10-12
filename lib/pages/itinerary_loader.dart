import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tourism_app/common/constants.dart';
import 'package:tourism_app/pages/itinerary_view.dart';
import 'package:tourism_app/services/activity_service.dart';
import 'package:tourism_app/services/budget_service.dart';
import 'package:tourism_app/services/category_service.dart';
import 'package:tourism_app/services/hotel_room_service.dart';
import 'package:tourism_app/services/hotel_service.dart';
import 'package:tourism_app/services/user_details_service.dart';
import 'package:tourism_app/services/vehicle_service.dart';

class ItineraryLoader extends StatefulWidget {
  const ItineraryLoader({super.key});

  @override
  State<ItineraryLoader> createState() => _ItineraryLoaderState();
}

class _ItineraryLoaderState extends State<ItineraryLoader> {
  Future<Map> collectData() async {
    // collect data from all boxes
    var data = {};
    var userDetails = await getUserDetails();
    var typePrefs = await getTypePrefs();
    var activities = await getActivities();
    var vehicle = await getSelectedVehicle();
    var hotelType = await getHotelTypePrefs();
    var roomTypePrefs = await getHotelRoomDetails();
    var budget = await getBudgetData();

    data['firstname'] = userDetails!.firstName;
    data['lastname'] = userDetails.lastName;
    data['numberOfAdults'] = userDetails.numberOfAdults;
    data['numberOfChildren'] = userDetails.numberOfChildren;
    data['country'] = userDetails.country;
    data['email'] = userDetails.email;
    data['telephone'] = userDetails.telephone;
    data['start'] = userDetails.start;
    data['end'] = userDetails.end;
    data['totalDays'] = userDetails.totalDays;
    data['typePrefs'] = typePrefs;
    data['activities'] = activities.map((e) => e.id).toList();
    data['vehicle'] = vehicle!.id;
    data['hotelType'] = hotelType;
    data['roomType'] = roomTypePrefs!.roomType;
    data['numberOfRooms'] = roomTypePrefs.numberOfRooms;
    data['mealType'] = roomTypePrefs.mealType;
    data['budget_amount'] = budget!.amount;
    data['special_needs'] = budget.specialNeeds;

    print(jsonEncode(data));

    return data;
  }

  Future<dynamic> sendRequest(Map data) async {
    // send request to the API and call /generate-itinerary using Dio
    var dio = Dio();
    Response response = await dio.post('$apiUrl/generate-itinerary',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
        data: data);

    if (response.statusCode != 200) {
      return {};
    }

    return response.data;
  }

  Future<void> complete(data) async {
    var genItinBox = Hive.box('generated_itinerary');
    genItinBox.put('itinerary', data['message']);

    // redirect to itinerary view
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ItineraryView(),
      ),
      (route) => true,
    );
  }

  void generateItinerary() async {
    var data = await collectData();
    var res = await sendRequest(data);
    await complete(res);
  }

  @override
  void initState() {
    super.initState();

    generateItinerary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/itinerary_generating.json',
                width: 400,
                height: 400,
                fit: BoxFit.fill,
              ),
              const Text(
                'We are carefully crafting the perfect itinerary for you!\nPlease wait...',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
