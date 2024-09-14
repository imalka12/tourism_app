import 'package:hive/hive.dart';
import 'package:tourism_app/models/user_details.dart';

Future<UserDetails> saveUserDetails(UserDetails userDetails) async {
  var userDetailsBox = await Hive.openBox<UserDetails>('user_details');
  userDetailsBox.put('user', userDetails);
  return userDetails;
}
