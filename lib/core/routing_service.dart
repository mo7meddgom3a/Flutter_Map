import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart';

class RoutingService {
  Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng end) async {
    final String url =
        'http://router.project-osrm.org/route/v1/driving/${start
        .longitude},${start.latitude};${end.longitude},${end
        .latitude}?overview=full&geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> coordinates =
      data['routes'][0]['geometry']['coordinates'];

      return coordinates.map((coord) {
        return LatLng(coord[1], coord[0]);
      }).toList();
    } else {
      throw Exception('Failed to fetch route');
    }
  }
}
