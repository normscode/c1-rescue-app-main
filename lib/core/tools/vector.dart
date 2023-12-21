import 'dart:math';

class Vector2D {
  double x;
  double y;

  Vector2D(this.x, this.y);

  factory Vector2D.zero() {
    return Vector2D(0, 0);
  }

  Map<String, dynamic> toMap() {
    return { 'x': x, 'y': y };
  }

  double get magnitude {
    return sqrt(x*x + y*y);
  }


  static add(Vector2D v1, Vector2D v2) {
    return Vector2D(v1.x + v2.x, v1.y + v2.y);
  }

  static scale(Vector2D v, double scalar) {
    return Vector2D(v.x * scalar, v.y * scalar);
  }

  @override
  String toString() {
    return "Vector2D($x, $y)";
  }

}

class Location {
  double latitude;
  double longitude;

  Location({ required this.longitude, required this.latitude });

  Map<String, dynamic> toMap() {
    return { 'longitude': longitude, 'latitude': latitude };
  }

  /// Returns the shortest distance (kms) between two geolocations
  static double getDistance(Location l1, Location l2) {
    return _getDistance(l1.latitude, l1.longitude, l2.latitude, l2.longitude);
  }
}


double _getDistance(double lat1, double lon1, double lat2, double lon2) {
  const r = 6372.8; // Earth radius in kilometers

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  final lat1Radians = _toRadians(lat1);
  final lat2Radians = _toRadians(lat2);

  final a = _haversin(dLat) + cos(lat1Radians) * cos(lat2Radians) * _haversin(dLon);
  final c = 2 * asin(sqrt(a));

  return r * c;
}

double _toRadians(double degrees) => degrees * pi / 180;

double _haversin(double radians) => pow(sin(radians / 2), 2).toDouble();