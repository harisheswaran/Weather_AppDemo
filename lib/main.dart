import 'package:flutter/material.dart';
import 'package:tutorial2/Weather.dart';

void main() {
  runApp(const WeatherApp());
}
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData.fallback(),
      home: const WeatherDemoApp(),
    );
  }
}

