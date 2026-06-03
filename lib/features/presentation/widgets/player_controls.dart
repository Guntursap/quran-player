import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });

  final bool isPlaying;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 64,
      onPressed: onPressed,
      icon: Icon(
        isPlaying
            ? Icons.pause_circle
            : Icons.play_circle,
      ),
    );
  }
}