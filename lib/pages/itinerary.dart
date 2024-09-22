import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tourism_app/pages/itinerary_view.dart';

class Itinerary extends StatelessWidget {
  const Itinerary({super.key});

  @override
  Widget build(BuildContext context) {
    // wait for 5 seconds and redirect to ItineraryView page
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ItineraryView()),
      );
    });

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
