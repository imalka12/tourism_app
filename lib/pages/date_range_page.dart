import 'package:flutter/material.dart';
import 'package:tourism_app/models/user_details.dart';
import 'package:tourism_app/pages/categories.dart';
import 'package:tourism_app/pages/user_details.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/services/user_details_service.dart';

class DateRangePage extends StatefulWidget {
  const DateRangePage({super.key});

  @override
  State<DateRangePage> createState() => _DateRangePageState();
}

class _DateRangePageState extends State<DateRangePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  DateTimeRange? _selectDateTime;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int totalDays = 0;

  Future<void> saveDateRangeAndGoToNext() async {
    if (_formKey.currentState!.validate()) {
      var dateRangeDatails = UserDetails.fromJson(<String, dynamic>{
        "start": _selectDateTime?.start.toString().split(' ')[0],
        "end": _selectDateTime?.end.toString().split(' ')[0],
        "totalDays": totalDays
      });
      saveUserDetails(dateRangeDatails);
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  void _show() async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Done',
    );

    if (result != null) {
      setState(() {
        _selectDateTime = result;
        _animationController.forward(from: 0.0);
        if (_selectDateTime != null) {
          totalDays =
              _selectDateTime!.end.difference(_selectDateTime!.start).inDays +
                  1;
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
              MaterialPageRoute(builder: (context) => UserDetailsPage()),
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
                shape: RoundedRectangleBorder(
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
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/date-picker.png',
                        height: 300,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _show,
                      icon: const Icon(Icons.calendar_today),
                      label: const Text(
                        "When is your trip?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: _selectDateTime == null
                          ? const Text(
                              'No dates selected.',
                              style: TextStyle(fontSize: 20),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.indigo, size: 30),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Arrival date: ${_selectDateTime?.start.toString().split(' ')[0]}',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.indigo, size: 30),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Departure date: ${_selectDateTime?.end.toString().split(' ')[0]}',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10),
                                      Text(
                                        '$totalDays Days Trip',
                                        style: const TextStyle(
                                            fontSize: 24, color: Colors.indigo),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton.icon(
              onPressed: () {
                saveDateRangeAndGoToNext().then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Categories(),
                    ),
                  );
                });
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next"),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
