import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_demo/logic/bloc/map_bloc.dart';
import 'package:mapbox_demo/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc(),
      child: const MaterialApp(
        title: 'Mapbox Demo',
        home: HomeScreen(),
      ),
    );
  }
}
