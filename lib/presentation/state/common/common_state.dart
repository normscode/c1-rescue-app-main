part of 'common_cubit.dart';

class GenderState {
  final String gender;

  GenderState({required this.gender});
}


class LatLngState {
  final ({double lat, double lng})? latlng;

  LatLngState({this.latlng});
}

class GeocodingState {
  final Placemark? data;

  GeocodingState({this.data});
}
