import 'package:flutter/material.dart';
import 'package:tourism_app/common/custom_button.dart';
import 'package:tourism_app/pages/user_details.dart';
import 'package:tourism_app/pages/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRect(
              child: Transform.scale(
                scale: 1.4,
                child: Align(
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/ET-logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sri Lanka",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "The Land Like No Other",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: CustomButton(
                  text: "Start Your Journey",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetailsPage()),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
