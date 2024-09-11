import 'package:flutter/material.dart';

class TourTypeSlider extends StatefulWidget {
  final String label;
  final Function(double) onSliderChange;

  const TourTypeSlider(
      {super.key, required this.label, required this.onSliderChange});

  @override
  State<TourTypeSlider> createState() => _TourTypeSliderState();
}

class _TourTypeSliderState extends State<TourTypeSlider> {
  double sliderPercentage = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(fontSize: 16),
          ),
          Slider(
            value: sliderPercentage,
            min: 0,
            max: 100,
            divisions: 100,
            label: '${(sliderPercentage).toStringAsFixed(0)}%',
            onChanged: (double newValue) {
              setState(() {
                sliderPercentage = newValue;
              });
              widget.onSliderChange(newValue);
            },
          ),
        ],
      ),
    );
  }
}
