import 'package:flutter/material.dart';
import 'package:mapbox_demo/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapbox Demo',
      home: const HomeScreen(),
    );
  }
}
