import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';

part 'common_state.dart';

class GenderCubit extends Cubit<GenderState> {
  GenderCubit() : super(GenderState(gender: 'Male'));

  void pickGender({
    required String title,
  }) {
    emit(GenderState(gender: title));
  }
}

List<({String enumValue, String title})> genderList = [
  (enumValue: 'MALE', title: 'Male'),
  (enumValue: 'FEMALE', title: 'Female'),
  (enumValue: 'N/A', title: 'Prefer not to say'),
];

class LatLngCubit extends Cubit<LatLngState> {
  LatLngCubit() : super(LatLngState());

  void updateLocation({required double lat, required double lng}) {
    emit(LatLngState(latlng: (lat: lat, lng: lng)));
  }

  
}

class GeocodingCubit extends Cubit<GeocodingState> {
  GeocodingCubit() : super(GeocodingState());
  
  Dio dio = Dio();

  Future<Placemark> getPlacemark(locationLat, locationLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(locationLat, locationLng);

    return placemarks[0];
  }

  Future<dynamic> getTravelTime(locationFromLat, locationFromLng, locationToLat, locationToLng) async {
    Response response = await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?departure_time=now&units=metric&origins=$locationFromLat,$locationFromLng&destinations=$locationToLat,$locationToLng&key=AIzaSyBL9W8OzS2n4pN8205Xv8FlSNjJS7VHvnU");

    if (response.data['status'] != "OK") return {};

    final data = response.data['rows'][0]['elements'][0];

    return {
      "distance": data['distance'],
      "duration": data['duration']
    };
  }
}