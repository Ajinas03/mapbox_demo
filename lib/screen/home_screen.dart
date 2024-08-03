import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_demo/logic/bloc/map_bloc.dart';
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
              Expanded(child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  return state.selectedLocation == null
                      ? Text("Please select a location to continue")
                      : MapWidget(
                          onMapCreated: _onMapCreated,
                          styleUri: MapboxStyles.SATELLITE_STREETS,
                          cameraOptions: CameraOptions(
                              center: Point(
                                  coordinates: Position(
                                      state.selectedLocation?.geometry
                                              ?.coordinates?[0] ??
                                          0.0,
                                      state.selectedLocation?.geometry
                                              ?.coordinates?[1] ??
                                          0.0)),
                              zoom: 12.0),
                        );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
