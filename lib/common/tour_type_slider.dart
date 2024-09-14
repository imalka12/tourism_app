import 'package:flutter/material.dart';

class TourTypeSlider extends StatefulWidget {
  final String label;
  final Function(double) onSliderChange;
  final double initialValue;

  const TourTypeSlider(
      {super.key,
      required this.label,
      required this.onSliderChange,
      required this.initialValue});

  @override
  State<TourTypeSlider> createState() => _TourTypeSliderState();
}

class _TourTypeSliderState extends State<TourTypeSlider> {
  @override
  Widget build(BuildContext context) {
    double sliderPercentage = widget.initialValue;

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
