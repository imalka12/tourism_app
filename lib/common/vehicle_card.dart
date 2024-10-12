import 'package:flutter/material.dart';
import 'package:tourism_app/models/vehicle.dart';

class VehicleCard extends StatefulWidget {
  final Vehicle vehicle;
  final bool isSelectedVehicle;
  final Function(String) onVehicleSelected;

  const VehicleCard(
      {super.key,
      required this.vehicle,
      required this.isSelectedVehicle,
      required this.onVehicleSelected});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        print('Vehicle selected: ${widget.vehicle.title}');
        widget.onVehicleSelected(widget.vehicle.title!);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          width: 200,
          decoration: BoxDecoration(
            color:
                widget.isSelectedVehicle ? Colors.blue.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: widget.isSelectedVehicle ? Colors.blue : Colors.grey,
                width: 1.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Image.asset(
                  'assets/car.png',
                  height: 150,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vehicle.title ?? 'No Title',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.vehicle.make!} ${widget.vehicle.model!}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Year: ${widget.vehicle.yom ?? 'N/A'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Price per km: \$${widget.vehicle.pricePerKm ?? 0.0}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
