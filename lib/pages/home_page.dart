import 'package:flutter/material.dart';
import 'package:tourism_app/pages/login_page.dart';
import 'package:tourism_app/pages/registration_page.dart';
import 'package:tourism_app/common/custom_button.dart';
import 'package:tourism_app/pages/user_details.dart';
import 'package:tourism_app/pages/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/sri_lanka_3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white, size: 50),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: UserProfile(),
                    );
                  },
                );
              },
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                "Welcome to Sri Lanka",
                style: TextStyle(
                  color: const Color.fromARGB(255, 6, 53, 91),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                  child: CustomButton(
                    text: "Start",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetails()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
