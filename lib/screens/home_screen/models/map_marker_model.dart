import 'package:latlong2/latlong.dart';

class MapMarkerModel {
  final String id;
  final String name;
  final String description;
  final LatLng position;

  final num discount;

  MapMarkerModel({
    required this.discount,
    required this.id,
    required this.name,
    required this.description,
    required this.position,
  });

  MapMarkerModel copyWith({
    num? discount,
    String? id,
    String? name,
    String? description,
    LatLng? position,
  }) {
    return MapMarkerModel(
      discount: discount ?? this.discount,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'discount': discount,
      'id': id,
      'name': name,
      'description': description,
      'position': {
        'latitude': position.latitude,
        'longitude': position.longitude,
      },
    };
  }

  factory MapMarkerModel.fromMap(Map<String, dynamic> map) {
    return MapMarkerModel(
      discount: map['discount'],
      id: map['id'],
      name: map['name'],
      description: map['description'],
      position: LatLng(
        map['position']['latitude'],
        map['position']['longitude'],
      ),
    );
  }

}