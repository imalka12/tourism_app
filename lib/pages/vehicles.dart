import 'package:flutter/material.dart';
import 'package:tourism_app/common/horizontal_scrollable_row.dart';
import 'package:tourism_app/common/vehicle_card.dart';
import 'package:tourism_app/models/vehicle.dart';
import 'package:tourism_app/pages/categories.dart';
import 'package:tourism_app/pages/hotels.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/services/vehicle_service.dart';

class Vehicles extends StatefulWidget {
  const Vehicles({super.key});

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  Vehicle? selectedVehicle;
  late Future<List<Vehicle>> vehiclesList;

  @override
  void initState() {
    super.initState();
    vehiclesList = getVehicles();

    // get selected vehicle from the box
    getSelectedVehicle().then((vehicle) {
      setState(() {
        selectedVehicle = vehicle;
      });
    });
  }

  void saveVehicleAndNavigate() {
    if (selectedVehicle != null) {
      saveVehicle(selectedVehicle!);

      // navigate to next page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Hotels()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a vehicle'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vehicle Preference',
          style: TextStyle(fontSize: 24),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const Categories()));
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
                    child: const UserProfile(),
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Choose your vehicle',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          // list of vehicles from getVehicles() future. must be able to scroll horizontally.
          FutureBuilder<List<Vehicle>>(
            future: vehiclesList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data!.isEmpty) {
                return const Center(child: Text('No vehicles found'));
              } else {
                return HorizontalScrollableRow(
                  children: snapshot.data!.map((vehicle) {
                    return VehicleCard(
                      vehicle: vehicle,
                      isSelectedVehicle: selectedVehicle?.id == vehicle.id,
                      onVehicleSelected: (p0) {
                        setState(() {
                          selectedVehicle = vehicle;
                        });
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
          const Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  saveVehicleAndNavigate();
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
          ),
        ],
      ),
    );
  }
}
