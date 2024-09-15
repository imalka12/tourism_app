import 'package:css_text/css_text.dart';
import 'package:flutter/material.dart';
import 'package:tourism_app/common/constants.dart';
import 'package:tourism_app/common/horizontal_scrollable_row.dart';
import 'package:tourism_app/models/hotel.dart';
import 'package:tourism_app/pages/hotel_details.dart';
import 'package:tourism_app/pages/user_profile.dart';
import 'package:tourism_app/pages/vehicles.dart';

import '../services/hotel_service.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  late Future<List<Hotel>> hotels;
  late List<String> hotelTypes; 

  Hotel? selectedHotel;
  // String? _selectedHotelType;

  @override
  void initState() {
    super.initState();
    hotels = getHotels();
    hotelTypes = getHotelTypes();


    // initialize selectedHotel with the first hotel in the hotels
    hotels.then((value) {
      if (value.isNotEmpty) {
        setState(() {
          selectedHotel = value.first;
        });
      }
    });
    

      if (hotelTypes.isNotEmpty) {
         print(hotelTypes);
        // setState(() {
        //   selectedHotel = value.first;
        // });
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
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => const Vehicles()));
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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'These are our hotels',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Hotel Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // value: _selectedHotelType,
                    // getHotelTypes()
                    items: {
                      'eco': 'Eco-Friendly',
                      'luxury': 'Luxury',
                    }.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      // setState(() {
                      //   _selectedHotelType = newValue;
                      // });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                FutureBuilder<List<Hotel>>(
                  future: hotels,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(child: Text('No hotels found'));
                    } else {
                      return HorizontalScrollableRow(
                        children: snapshot.data!
                            .map(
                              (hotel) => HotelTile(
                                hotel: hotel,
                                onHotelSelected: (hotel) {
                                  setState(() {
                                    selectedHotel = hotel;
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                selectedHotel != null
                    ? HotelDetail(selectedHotel: selectedHotel!)
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                const SizedBox(height: 128),
              ],
            ),
          ),
          Positioned(
            right: 20.0,
            bottom: 20.0,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HotelDetails()),
                );
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

Widget buildStarRating(int rating) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      );
    }),
  );
}

class HotelTile extends StatelessWidget {
  final Hotel hotel;
  final Function(Hotel) onHotelSelected;
  const HotelTile({
    super.key,
    required this.hotel,
    required this.onHotelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onHotelSelected(hotel);
      },
      child: Stack(children: [
        Container(
          width: 300,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.white,
          child: Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(storageUrl + hotel.image!),
                fit: BoxFit.cover,
              ),
              // add shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 8.0,
          left: 16.0,
          height: 32.0,
          child: Text(
            hotel.name!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ]),
    );
  }
}

class HotelDetail extends StatelessWidget {
  final Hotel? selectedHotel;
  const HotelDetail({super.key, this.selectedHotel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: selectedHotel == null
          ? const Text('No hotel selected')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text(
                          //   selectedHotel!.name!,
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black,
                          //   ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedHotel!.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              buildStarRating(selectedHotel?.starRating ?? 0),
                            ],
                          ),
                          const SizedBox(height: 16),
                          HTML.toRichText(
                            context,
                            selectedHotel!.description!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
