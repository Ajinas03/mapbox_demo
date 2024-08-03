import 'package:flutter/material.dart';
import 'package:mapbox_demo/screen/widgets/expandable_container.dart';
import 'package:mapbox_demo/screen/widgets/search_with_suggestion_widget.dart';
import 'package:mapbox_demo/service/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> suggestions = [
      'Apple',
      'Banana',
      'Cherry',
      'Date',
      'Elderberry',
      'Fig',
      'Grape',
      'Honeydew',
      'Kiwi',
      'Lemon',
    ];

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: size(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ExpandableContainer(
                title: 'Expandable Section',
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      SearchWithSuggestions(
                          hintText: "From", suggestions: suggestions),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      SearchWithSuggestions(
                          hintText: "To", suggestions: suggestions),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: MapWidget(
                onMapCreated: _onMapCreated,
                cameraOptions: CameraOptions(
                    center: Point(coordinates: Position(-80.1263, 25.7845)),
                    zoom: 12.0),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
