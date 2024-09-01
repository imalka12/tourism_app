import 'package:hive/hive.dart';
import 'package:tourism_app/models/user_details.dart';

Future<UserDetails> saveUserDetails(UserDetails userDetails) async {
  var userDetailsBox = await Hive.openBox<UserDetails>('user_details');
  userDetailsBox.put('user', userDetails);

  var user = userDetailsBox.get('user');
  print('received firstname as ${user!.firstName}');
  print('received lastName as ${user!.lastName}');
  print('received numberOfAdults as ${user!.numberOfAdults}');
  print('received numberOfChildren as ${user!.numberOfChildren}');
  print('received county as ${user!.country}');
  print('received email as ${user!.email}');
  print('received telephone as ${user!.telephone}');
  return userDetails;
}