import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:tourism_app/models/hotel_room.dart';

Future<HotelRoom> saveHotelRoomDetails(HotelRoom hotelRoomDetails) async {
  print('${hotelRoomDetails}');
  var hotelRoomDetailsBox = await Hive.openBox<HotelRoom>('hotel_room_details');
  hotelRoomDetailsBox.put('roomDetails', hotelRoomDetails);
  return hotelRoomDetails;
}