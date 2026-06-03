import 'package:flutter/material.dart';
import 'package:quran_player/app/quran_player_app.dart';
import 'package:quran_player/core/di/service_locator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  runApp(
    const QuranPlayerApp(),
  );
}