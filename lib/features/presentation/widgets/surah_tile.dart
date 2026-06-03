import 'package:flutter/material.dart';

class SurahTile extends StatelessWidget {
  const SurahTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.play_arrow),
      onTap: onTap,
    );
  }
}