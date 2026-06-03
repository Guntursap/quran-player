import 'package:flutter/material.dart';

class AudioProgress extends StatelessWidget {
  const AudioProgress({
    super.key,
    required this.value,
    required this.max,
    required this.onChanged,
  });

  final double value;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value.clamp(0, max),
      max: max <= 0 ? 1 : max,
      onChanged: onChanged,
    );
  }
}