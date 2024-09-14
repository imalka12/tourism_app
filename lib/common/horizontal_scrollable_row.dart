import 'package:flutter/material.dart';

class HorizontalScrollableRow extends StatelessWidget {
  final List<Widget> children;

  const HorizontalScrollableRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: children,
      ),
    );
  }
}
