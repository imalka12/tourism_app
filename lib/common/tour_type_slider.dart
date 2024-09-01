import 'package:flutter/material.dart';

class TourTypeSlider extends StatefulWidget {
  final String label;
  final Function(double) onSliderChange;

  const TourTypeSlider({super.key, required this.label, required this.onSliderChange});

  @override
  State<TourTypeSlider> createState() => _TourTypeSliderState();
}

class _TourTypeSliderState extends State<TourTypeSlider> {
  double sliderPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 16),
        ),
        Slider(
          value: sliderPercentage,
          min: 0.0,
          max: 1.0,
          divisions: 100,
          label: '${(sliderPercentage * 100).toStringAsFixed(0)}%',
          onChanged: (double newValue) {
            setState(() {
              sliderPercentage = newValue;
            });
            widget.onSliderChange(newValue);
          },
        ),
      ],
    );
  }
}