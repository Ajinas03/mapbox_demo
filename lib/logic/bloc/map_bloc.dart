import 'package:bloc/bloc.dart';
import 'package:mapbox_demo/model/search_model.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mapB;

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitial()) {
    bool isExpanded = false;
    Feature? selectedMapLocation;
    on<MapEvent>((event, emit) {
      if (event is ExpandAppBar) {
        isExpanded = event.isExpand;

        emit(MapState(
            isExpanded: isExpanded, selectedLocation: selectedMapLocation));
      }
      if (event is SelctMapLocation) {
        selectedMapLocation = event.selectedLocation;
        isExpanded = false;

        emit(MapState(
            isExpanded: isExpanded, selectedLocation: selectedMapLocation));
      }
    });
  }
}
