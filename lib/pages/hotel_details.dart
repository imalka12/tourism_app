import 'package:flutter/material.dart';
import 'package:tourism_app/models/hotel_room.dart';
import 'package:tourism_app/pages/budget.dart';
import 'package:tourism_app/pages/home_page.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/services/hotel_room_service.dart';

class HotelDetails extends StatefulWidget {
  const HotelDetails({super.key});

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> roomTypes = [
    {"type": "Single", "value": "single", "icon": Icons.single_bed},
    {"type": "Double", "value": "double", "icon": Icons.bed},
    {"type": "Triple", "value": "triple", "icon": Icons.bedroom_child},
    {"type": "Family", "value": "family", "icon": Icons.family_restroom},
    {"type": "Dormitory", "value": "dormitory", "icon": Icons.single_bed_sharp},
  ];

  final TextEditingController _numberOfRoomsController =
      TextEditingController();
  String? _selectedRoomType;
  String? _selectedMealType;

  Future<void> saveHotelRoomDetailsAndGoToNext() async {
    if (_formKey.currentState!.validate()) {
      var hotelRoomDetail = HotelRoom.fromJson(<String, dynamic>{
        "roomType": _selectedRoomType,
        'numberOfRooms': _numberOfRoomsController.text,
        'mealType': _selectedMealType,
      });
      saveHotelRoomDetails(hotelRoomDetail);
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
              MaterialPageRoute(builder: (context) => const HomePage()),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'Select Room Type',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      hint: const Text('Select a room type'),
                      value: _selectedRoomType,
                      items: roomTypes.map((room) {
                        return DropdownMenuItem<String>(
                          value: room['value'],
                          child: Row(
                            children: [
                              Icon(room['icon']),
                              const SizedBox(width: 10),
                              Text(room['type']),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedRoomType = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _numberOfRoomsController,
                      decoration: InputDecoration(
                        labelText: 'Number of Rooms',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.meeting_room),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Meal Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      value: _selectedMealType,
                      items: {
                        'none': 'Room Only',
                        'bb': 'Bed & Breakfast',
                        'hb': 'Half-board',
                        'fb': 'Full-board',
                      }.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedMealType = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    saveHotelRoomDetailsAndGoToNext().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Budget(),
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text("Next"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    textStyle: const TextStyle(fontSize: 20),
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
