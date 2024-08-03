import 'dart:convert';
import 'dart:developer';

import 'package:mapbox_demo/model/search_model.dart';
import 'package:http/http.dart' as http;

class Search {
  final String mapboxAccessToken =
      'sk.eyJ1IjoiYWtoaWxsZXZha3VtYXIiLCJhIjoiY2x4MDcxM3JlMGM5YTJxc2Q1cHc4MHkyZSJ9.awWNy5HErR8ooOddFDR6Gg';
  final String searchApiUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places/';
  Future<List<Feature>> getPlaces(String searchText) async {
    SearchModel? searchModel;

    try {
      final response = await http.get(Uri.parse(
          '$searchApiUrl$searchText.json?access_token=$mapboxAccessToken'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        searchModel = SearchModel.fromJson(data);
        log("search result : ${searchModel.features}");

        return searchModel.features ?? [];
      } else {
        print('Failed to perform search');
        return [];
      }
    } on Exception catch (e) {
      log("search result exception : $e");
      return [];
    }
  }
}
