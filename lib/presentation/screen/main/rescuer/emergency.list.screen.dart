
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';
import 'package:ralert/presentation/state/emergency_list/emergency_list_cubit.dart';

@RoutePage()
class EmergenciesListScreen extends StatefulWidget {
  const EmergenciesListScreen({super.key});

  @override
  State<EmergenciesListScreen> createState() => _EmergenciesListScreenState();
}

class _EmergenciesListScreenState extends State<EmergenciesListScreen> {

  @override
  void initState() {
    super.initState();

    context.read<EmergencyListCubit>().getIncidents();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: "On Going", icon: Icon(Icons.on_device_training_outlined)),
              Tab(text: "Unsolved", icon: Icon(Icons.car_crash)),
              Tab(text: "Resolved", icon: Icon(Icons.check)),
            ],
          ),
          title: const Text('Emergencies Now', style: TextStyle(color: Colors.black)),
        ),
        body: const TabBarView(
          children: [
            EmergencyTab("on-going"),
            EmergencyTab("unsolved"),
            EmergencyTab("resolved")
          ],
        ),
      ),
    );
  }

}

class IncidentItem extends StatefulWidget {

  final dynamic data;
  final Function() onTap;

  const IncidentItem(this.data, this.onTap, {super.key});

  @override
  State<IncidentItem> createState() => _IncidentItemState();
}

class _IncidentItemState extends State<IncidentItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<GeocodingCubit>().getPlacemark(widget.data['locationLat'], widget.data['locationLng']),
      builder: (context, snapshot) {
        
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        Timestamp t = widget.data['dateTime'];
        DateTime date = t.toDate();

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.car_crash,
                        size: 35,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${date.month}-${date.day}-${date.year} / ${date.hour}:${date.minute}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(snapshot.data?.street ?? "Loading...",
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                  fontSize: 20
                                )
                              ),
                            ),
                          ),
                          Text("${snapshot.data?.locality ?? 'Loading...'}, ${snapshot.data?.administrativeArea ?? 'Loading...'}"),
                          const SizedBox(height: 5),
                          Text(widget.data['lifeThreatening'] == true
                            ? "HIGH PRIORITY"
                            : "LOW PRIORITY",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: widget.data['lifeThreatening'] == true
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.black
                              )
                          )
                        ],
                      )
                    ],
                  ),
            
                  const SizedBox()
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}

class EmergencyTab extends StatefulWidget {
  const EmergencyTab(this.tabName, {super.key});

  final String tabName;

  @override
  State<EmergencyTab> createState() => _EmergencyTabState();
}

class _EmergencyTabState extends State<EmergencyTab> {

  late Future<List<dynamic>> read;
  bool viewOnly = false;

  @override
  void initState() {

    if (widget.tabName == "on-going") {
      read = context.read<EmergencyListCubit>().getAccepted();
    } else if (widget.tabName == "unsolved") {
      read = context.read<EmergencyListCubit>().getUnsolved();
    } else if (widget.tabName == "resolved") {
      viewOnly = true;
      read = context.read<EmergencyListCubit>().getResolvedRescuer();
    } else {
      EasyLoading.showError("Something went wrong");
      read = context.read<EmergencyListCubit>().getUnsolved();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: read,
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        final data = snapshot.data;

        if (data == null) {
          return const Center(child: Text("Something went wrong", textAlign: TextAlign.center));
        }

        if (data.isEmpty) {
          return const Center(child: Text("No data", textAlign: TextAlign.center));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return IncidentItem(data[i], () {
              if (viewOnly) {
                context.router.push(IncidentViewRoute(data: data[i]));
              } else {
                context.router.push(IncidentRoute(data: data[i]));
              }
            });
          },
        );
      }
    );
  }
}