part of 'map_bloc.dart';

abstract class MapEvent {}

class ExpandAppBar extends MapEvent {
  final bool isExpand;

  ExpandAppBar({required this.isExpand});
}

class SelctMapLocation extends MapEvent {
  final Feature selectedLocation;

  SelctMapLocation({required this.selectedLocation});
}

class SearchMap extends MapEvent {
  final String searchtext;

  SearchMap({required this.searchtext});
}

class AddMarkerEvent extends MapEvent {
  final double longitude;
  final double latitude;

  AddMarkerEvent(this.longitude, this.latitude);
}
