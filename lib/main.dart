import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:tourism_app/models/activity.dart";
import "package:tourism_app/models/category.dart";
import "package:tourism_app/models/hotel.dart";
import "package:tourism_app/models/user_details.dart";
import "package:tourism_app/models/vehicle.dart";
import "package:tourism_app/pages/home_page.dart";

void main() async {
  //init flutter
  await Hive.initFlutter();

  //register adapters
  Hive.registerAdapter(UserDetailsAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ActivityAdapter());
  Hive.registerAdapter(VehicleAdapter());
  Hive.registerAdapter(HotelAdapter());

  // open boxes
  await Hive.openBox<UserDetails>('user_details');
  await Hive.openBox('categories');
  await Hive.openBox('activities');
  await Hive.openBox('rooms');
  await Hive.openBox('dates');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      title: "Tourism App",
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
    );
  }
}
