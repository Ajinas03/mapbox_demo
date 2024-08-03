part of 'map_bloc.dart';

class MapState {
  bool isExpanded;
  Feature? selectedLocation;
  MapState({required this.isExpanded, this.selectedLocation});
}

final class MapInitial extends MapState {
  MapInitial() : super(isExpanded: false, selectedLocation: null);
}
