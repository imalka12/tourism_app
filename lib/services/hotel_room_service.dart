import 'package:hive/hive.dart';
import 'package:tourism_app/models/hotel_room.dart';

Future<HotelRoom> saveHotelRoomDetails(HotelRoom hotelRoomDetails) async {
  var hotelRoomDetailsBox = Hive.box<HotelRoom>('hotel_room_details');
  hotelRoomDetailsBox.put('roomDetails', hotelRoomDetails);
  return hotelRoomDetails;
}

// get saved hotel room details
Future<HotelRoom?> getHotelRoomDetails() async {
  var hotelRoomDetailsBox = Hive.box<HotelRoom>('hotel_room_details');
  return hotelRoomDetailsBox.get('roomDetails');
}
