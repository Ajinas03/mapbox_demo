// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  String? type;
  List<String>? query;
  List<Feature>? features;
  String? attribution;

  SearchModel({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        type: json["type"],
        query: json["query"] == null
            ? []
            : List<String>.from(json["query"]?.map((x) => x)),
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]?.map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "query":
            query == null ? [] : List<dynamic>.from(query?.map((x) => x) ?? []),
        "features": features == null
            ? []
            : List<dynamic>.from(features?.map((x) => x.toJson()) ?? []),
        "attribution": attribution,
      };
}

class Feature {
  String? id;
  String? type;
  List<String>? placeType;
  int? relevance;
  Properties? properties;
  String? text;
  String? placeName;
  List<double>? bbox;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;

  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: json["place_type"] == null
            ? []
            : List<String>.from(json["place_type"]?.map((x) => x)),
        relevance: json["relevance"],
        properties: json["properties"] == null
            ? null
            : Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        bbox: json["bbox"] == null
            ? []
            : List<double>.from(json["bbox"]?.map((x) => x?.toDouble())),
        center: json["center"] == null
            ? []
            : List<double>.from(json["center"]?.map((x) => x?.toDouble())),
        geometry: json["geometry"] == null
            ? null
            : Geometry.fromJson(json["geometry"]),
        context: json["context"] == null
            ? []
            : List<Context>.from(
                json["context"]?.map((x) => Context.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": placeType == null
            ? []
            : List<dynamic>.from(placeType?.map((x) => x) ?? []),
        "relevance": relevance,
        "properties": properties?.toJson(),
        "text": text,
        "place_name": placeName,
        "bbox":
            bbox == null ? [] : List<dynamic>.from(bbox?.map((x) => x) ?? []),
        "center": center == null
            ? []
            : List<dynamic>.from(center?.map((x) => x) ?? []),
        "geometry": geometry?.toJson(),
        "context": context == null
            ? []
            : List<dynamic>.from(context?.map((x) => x.toJson()) ?? []),
      };
}

class Context {
  String? id;
  String? mapboxId;
  String? wikidata;
  String? text;

  Context({
    this.id,
    this.mapboxId,
    this.wikidata,
    this.text,
  });

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
        "text": text,
      };
}

enum ShortCode { US, US_FL }

final shortCodeValues =
    EnumValues({"us": ShortCode.US, "US-FL": ShortCode.US_FL});

class Geometry {
  String? type;
  List<double>? coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]?.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates?.map((x) => x) ?? []),
      };
}

class Properties {
  String? mapboxId;
  String? wikidata;
  String? foursquare;
  String? address;
  bool? landmark;
  String? category;
  String? maki;

  Properties({
    this.mapboxId,
    this.wikidata,
    this.foursquare,
    this.address,
    this.landmark,
    this.category,
    this.maki,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"],
        wikidata: json["wikidata"],
        foursquare: json["foursquare"],
        address: json["address"],
        landmark: json["landmark"],
        category: json["category"],
        maki: json["maki"],
      );

  Map<String, dynamic> toJson() => {
        "mapbox_id": mapboxId,
        "wikidata": wikidata,
        "foursquare": foursquare,
        "address": address,
        "landmark": landmark,
        "category": category,
        "maki": maki,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
