import 'package:hive/hive.dart';
import 'package:tourism_app/models/user_details.dart';

Future<UserDetails> saveUserDetails(UserDetails userDetails) async {
  var userDetailsBox = await Hive.openBox<UserDetails>('user_details');
  var existingUser = userDetailsBox.get('user');

  if (existingUser == null) {
    userDetailsBox.put('user', userDetails);
  } else {
    // update the existing user for all fields
    existingUser.firstName = userDetails.firstName;
    existingUser.lastName = userDetails.lastName;
    existingUser.numberOfAdults = userDetails.numberOfAdults;
    existingUser.numberOfChildren = userDetails.numberOfChildren;
    existingUser.email = userDetails.email;
    existingUser.telephone = userDetails.telephone;
    existingUser.country = userDetails.country;
    userDetailsBox.put('user', existingUser);
  }

  return userDetails;
}

Future<UserDetails> saveDateDetails(UserDetails userDetails) async {
  var userDetailsBox = await Hive.openBox<UserDetails>('user_details');
  var existingUser = userDetailsBox.get('user');
  existingUser!.start = userDetails.start;
  existingUser.end = userDetails.end;
  existingUser.totalDays = userDetails.totalDays;
  userDetailsBox.put('user', existingUser);

  return existingUser;
}

// get user details from the box
Future<UserDetails?> getUserDetails() async {
  var userDetailsBox = await Hive.openBox<UserDetails>('user_details');
  return userDetailsBox.get('user');
}
