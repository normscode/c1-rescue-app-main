
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';
import 'package:ralert/presentation/state/emergency/emergency_cubit.dart';
import 'package:ralert/presentation/state/emergency_live/emergency_live_cubit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class SOSScreen extends StatefulWidget {
  final bool? alertSent;
  final int? startingDuration;
  final bool? fromCarCrash;

  const SOSScreen({super.key , this.alertSent, this.startingDuration, this.fromCarCrash});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {

  bool announcedEmergency = false;
  int startingDuration = 15;
  bool fromCarCrash = false;

  bool errorOccured = false;

  @override
  void initState() {
    super.initState();

    announcedEmergency = widget.alertSent != null ? widget.alertSent! : announcedEmergency;
    startingDuration = widget.startingDuration != null ? widget.startingDuration! : startingDuration;
    fromCarCrash = widget.fromCarCrash != null ? widget.fromCarCrash! : fromCarCrash;

    if (announcedEmergency) {
      announce(true);
    }
  }

  Future<void> announce(bool lifeThreatening) async {
    final emergencyId = await context.read<EmergencyCubit>().sendSOS(lifeThreatening: lifeThreatening);
    
    // ignore: use_build_context_synchronously
    context.read<EmergencyLiveCubit>().onLiveUser(emergencyId);
  }

  Future<Map<String, dynamic>> getDistanceMatrix(rescuer, userLocation) async {
    try {
      return await context.read<GeocodingCubit>().getTravelTime(
        rescuer.location.latitude,
        rescuer.location.longitude,
        userLocation!.lat,
        userLocation.lng
      );
    } catch (e) {
      EasyLoading.showError("Something went wrong getting travel time: $e");

      return {
        "distance": "Unable to fetch distance",
        "duration": "Unable to fetch travel ETA"
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("EMERGENCY\nSIGNAL",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF363636)
                      )
                    ),
                    const SizedBox(height: 10),
                    Text(!announcedEmergency
                      ? fromCarCrash
                        ? "We have detected unusual shaking of your phone, we anticipate this as a car crash emergency.\n\nWe'll get help immediately after"
                        : "We'll get help after"
                      : "The distress signal has been sent to nearby rescuers. Help is coming your way.",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF363636)
                      )
                    ),
                  ],
                ),
              ),
              
              Center(
                child: Column(
                  children: [
                    !announcedEmergency
                      ? CircularCountDownTimer(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 2.5,
                        duration: startingDuration,
                        strokeWidth: 20,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        ringColor: Theme.of(context).primaryColor,
                        isReverse: true,
                        isReverseAnimation: true,
                        textStyle: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                        onComplete: () {
                          announce(true);

                          setState(() {
                            announcedEmergency = true;
                          });
                        },
                      )
                      : BlocBuilder<EmergencyLiveCubit, EmergencyLiveState>(
                          builder: (context, state) {

                            if (state is EmergencyAcceptedState) {

                              print("State is Accepted and data is ${state.data}");
                            
                              try {
                                final RescuerModel rescuer = state.data;
                                final userLocation = context.select(
                                  (LatLngCubit latlng) => latlng.state.latlng,
                                );

                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Icon(
                                        Icons.health_and_safety_outlined,
                                        size: MediaQuery.of(context).size.width / 2,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                      ),
                                      const SizedBox(height: 30),
                                      Text("We have found a rescuer!\nHelp is on the way.", 
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary
                                        )
                                      ),
                                      const SizedBox(height: 30),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Rescuer Details",
                                              style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                            const SizedBox(height: 5),
                                            FutureBuilder(
                                              future: getDistanceMatrix(rescuer, userLocation),
                                              builder: (context, snapshot) {

                                                if (!snapshot.hasData) {
                                                  return const Center(
                                                    child: CircularProgressIndicator.adaptive(),
                                                  );
                                                }

                                                return _buildInfo([
                                                  {'title': 'NAME', 'info': "${rescuer.firstName} ${rescuer.lastName}"},
                                                  {'title': 'CONTACT NUMBER', 'info': rescuer.contactNumber},
                                                  {'title': 'DISTANCE', 'info': snapshot.data!['distance']['text']},
                                                  {'title': 'ETA', 'info': snapshot.data!['duration']['text']}
                                                ]);
                                              }
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } catch (e) {
                                EasyLoading.showToast("Something went wrong $e");
                              }
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Center(
                                    child: LoadingAnimationWidget.beat(
                                      color: Theme.of(context).colorScheme.secondary,
                                      size: 150,
                                    )
                                  ),
                                  const SizedBox(height: 50),
                                  Text("Hang tight! We're now alerting nearby rescuers in your area.", 
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.secondary
                                    )
                                  )
                                ],
                              ),
                            );
                          }
                        ),

                    fromCarCrash
                      ? const SizedBox()
                      : announcedEmergency
                        ? const SizedBox()
                        : GestureDetector(
                          onTap: () {
                            announce(false);

                            setState(() {
                              announcedEmergency = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.black, width: 0.7),
                              borderRadius: BorderRadius.circular(3)
                            ),
                            child: const Column(
                              children: [
                                Text("NOT LIFE THREATENING", style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                Text("(NOT ALARMING, LOW PRIO)", style: TextStyle(color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        
                    announcedEmergency
                      ? const SizedBox()
                      : Column(
                        children: [

                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {

                              if (fromCarCrash) {
                                exit(0);
                              } else {
                                context.router.pop();
                              }

                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(3)
                              ),
                              child: const Column(
                                children: [
                                  Text("CANCEL", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
                                  Text("(FALSE ALARM)", style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                )
              ),


            ],
          ),
        ),
      ),
    );
  }

  _buildInfo(List<Map<String, dynamic>> items) {

    buildItem(String title, info, bool? isList) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
            isList != null && isList
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: info.length <= 0
                    ? [Text("None",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.secondary
                        ),
                      )]
                    : [...info.map((item) => Text(item,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ))]
                  ,
                )
              : Text(info,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary
                  ),
                )
          ],
        ),
      );
    }

    return Column(
      children: [
        ...items.map((item) => buildItem(item['title'], item['info'], item['isList']))
      ],
    );
  }
}