
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/emergency_live/emergency_live_cubit.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';

class IncidentAlertWidget extends StatefulWidget {
  const IncidentAlertWidget(this.data, {super.key});

  final dynamic data;

  @override
  State<IncidentAlertWidget> createState() => _IncidentAlertWidgetState();
}

class _IncidentAlertWidgetState extends State<IncidentAlertWidget> {

  bool automaticCarCrashDetection = false;

  @override
  void initState() {
    super.initState();
    context.read<EmergencyLiveCubit>().onLive(widget.data['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor
      ),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                _buildLabel(),
                FutureBuilder(
                  future: context.read<GeocodingCubit>().getPlacemark(widget.data['locationLat'], widget.data['locationLng']),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    return _buildInformation(snapshot.data);
                  }
                )
              ],
            ),
          ),
          _buildTime()
        ],
      ),
    );
  }

  _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(widget.data['emergencyType'] != 'distress-signal'
                  ? Icons.car_crash
                  : Icons.warning,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['emergencyType'] != 'distress-signal'
                      ? "CAR CRASH DETECTED"
                      : "DISTRESS SIGNAL DETECTED"
                    ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                  Text(
                    widget.data['lifeThreatening'] == true
                      ? "HIGH PRIORITY"
                      : "LOW PRIORITY"
                    ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                ],
              )
            ]
          ),
        ],
      ),
    );
  }

  _buildInformation(placemark) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(placemark?.street ?? 'Loading...',
                  overflow: TextOverflow.visible,
                  style: const TextStyle(
                    fontSize: 24
                  ),
                ),
                Text("${placemark?.locality ?? 'Loading...'}, ${placemark?.administrativeArea ?? 'Loading...'}", overflow: TextOverflow.ellipsis,)
              ],
            ),
          ),
    
          InkWell(
            onTap: () {
              context.router.push(IncidentRoute(data: widget.data));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2.3),
                borderRadius: BorderRadius.circular(3)
              ),
              child: Text("VIEW",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  _buildTime() {

    Timestamp t = widget.data['dateTime'] as Timestamp;
    DateTime date = t.toDate();

    final ago = timeago.format(date);

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(Icons.av_timer_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 3),
              Text("${date.month}-${date.day}-${date.year} / ${date.hour}:${date.minute}",
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          Row(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 3),
              Text(ago,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }

}