part of 'map_bloc.dart';

class MapState {
  bool isExpanded;
  Feature? selectedLocation;
  List<mapB.PointAnnotation>? markers;

  MapState({required this.isExpanded, this.selectedLocation, this.markers});
}

final class MapInitial extends MapState {
  MapInitial() : super(isExpanded: false, selectedLocation: null, markers: []);
}
