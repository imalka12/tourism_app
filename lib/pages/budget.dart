import 'package:flutter/material.dart';
import 'package:tourism_app/models/user_details.dart';
import 'package:tourism_app/pages/hotel_details.dart';
import 'package:tourism_app/pages/itinerary.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/services/user_details_service.dart';

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _budget = TextEditingController();
  final TextEditingController _specialNeeds = TextEditingController();


  Future<void> saveBudgetDetailsAndGoToNext() async {
    if (_formKey.currentState!.validate()) {
      var budgetDetail = UserDetails.fromJson(<String, dynamic>{
        "budget": _budget.text,
      });
      saveUserDetails(budgetDetail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plan your trip',
          style: TextStyle(fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const HotelDetails()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 32),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0)),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: UserProfile(),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  TextField(
                    controller: _budget,
                    decoration: InputDecoration(
                      labelText: 'Enter your budget',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _specialNeeds,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Any special needs?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.notes),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  saveBudgetDetailsAndGoToNext().then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Itinerary(),
                      ),
                    );
                  });
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Generate Itinerary"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
