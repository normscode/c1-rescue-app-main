
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';
import 'package:ralert/presentation/state/emergency_live/emergency_live_cubit.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {

  final Location location = Location();

  GoogleMapController? googleMapController;
  
  LocationData? currentUserPosition;
  StreamSubscription<LocationData>? _locationSubscription;

  BitmapDescriptor incidentLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    _request();
    super.initState();

    _listenLocation();
    location.changeSettings(interval: 300, accuracy: LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
    // generateMarkers();
  }

  @override
  void dispose() {
    super.dispose();

    googleMapController!.dispose();
    _locationSubscription!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {

        final latLng = context.select(
          (LatLngCubit latlng) => latlng.state.latlng
        );

        return BlocConsumer<EmergencyLiveCubit, EmergencyLiveState>(
          listener: (context, state) {
            if (state is EmergencyOfflineState) {
              if (latLng == null) return;
              
              mymap(lat: latLng!.lat, lng: latLng.lng);
            }
          },
          builder: (context, state) {
            return GoogleMap(
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: (controller) async {
                setState(() {
                  googleMapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                zoom: 19,
                target: LatLng(
                  latLng?.lat ?? 14.689236,
                  latLng?.lng ?? 121.102684
                )
              ),
              markers: {
                // incident != null
                //   ? Marker(
                //     infoWindow: const InfoWindow(title: 'Incident'),
                //     markerId: const MarkerId("1"),
                //     position: const LatLng(
                //       14.649172,
                //       121.051274,
                //     ),
                //     icon: incidentLocationIcon,
                //   ) : const Marker(markerId: MarkerId("2")),
              },
            );
          }, 
        );
      },
    );
  }

  Future<void> _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      _locationSubscription?.cancel();

      setState(() {
        _locationSubscription = null;
      });
      
    }).listen((event) async {
      context.read<LatLngCubit>().updateLocation(
        lat: event.latitude ?? 0,
        lng: event.longitude ?? 0,
      );
      currentUserPosition = event;
    });
  }

  Future<void> mymap({required double lat, required double lng}) async {
    await googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );
  }

  // generateMarkers() async {
  //   await BitmapDescriptor.fromAssetImage(
  //     const ImageConfiguration(),
  //     'assets/icons/carcrash-icon.png',
  //   ).then((value) {
  //     setState(() {
  //       incidentLocationIcon = value;
  //     });
  //   });
  // }

  _request() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      _request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}