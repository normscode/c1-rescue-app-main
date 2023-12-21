
// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';
import 'package:ralert/presentation/state/emergency/emergency_cubit.dart';
import 'package:ralert/presentation/widgets/common_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

@RoutePage()
class IncidentScreen extends StatefulWidget {
  const IncidentScreen(this.data, {super.key});

  final dynamic data; 

  @override
  State<IncidentScreen> createState() => _IncidentScreenState();
}

class _IncidentScreenState extends State<IncidentScreen> {

  bool medicalInfoShown = false;

  void launchGoogleMaps(double lat, double lng) async {
    var url = 'google.navigation:q=${lat.toString()},${lng.toString()}';
    var fallbackUrl =
        'https://www.google.com/maps/search/?api=1&query=${lat.toString()},${lng.toString()}';
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  void initState() {
    super.initState();

    try {
      context.read<EmergencyCubit>().checkEmergencyAcceptance(widget.data['accepted']);
    } catch (e) {
      EasyLoading.showError("Something went wrong: Outdated data properties. Please kindly contact the system administrator.", duration: const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {

    Timestamp t = widget.data['dateTime'] as Timestamp;
    DateTime date = t.toDate();

    final ago = timeago.format(date);

    // final liveState = context.select(
    //   (EmergencyLiveCubit live) => live.state
    // );

    // if (liveState is EmergencyOfflineState) {
    //   return Scaffold(
    //     backgroundColor: Theme.of(context).primaryColor,
    //     appBar: AppBar(
    //       backgroundColor: Colors.transparent,
    //     ),
    //     body: Center(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 30),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Text("THE INCIDENT HAS BEEN RESOLVED. THANK YOU FOR YOUR HELP!",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                 fontSize: 25,
    //                 fontWeight: FontWeight.bold
    //               ),
    //             ),
    //             const SizedBox(height: 50),
    //             CommonButton(
    //               onTap: () {
    //                 context.router.pop();
    //               },
    //               text: "GO HOME"
    //             )
    //           ],
    //         ),
    //       ),
    //     )
    //   );
    // }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(widget.data['emergencyType'] != 'distress-signal'
                        ? Icons.car_crash
                        : Icons.warning,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 5),
                    Text(widget.data['emergencyType'] != 'distress-signal'
                        ? "CAR CRASH DETECTED"
                        : "DISTRESS SIGNAL DETECTED"
                      ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                  ],
                ),
      
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
                ),
      
                const Divider(thickness: 3.5),
      
                _buildInfo([
                  {'title': 'DATE DETECTED', 'info': "${date.month}-${date.day}-${date.year}"},
                  {'title': 'TIME DETECTED', 'info': "${date.hour}:${date.minute}"},
                  {'title': 'TIME ELAPSED', 'info': ago},
                  {'title': 'ACCELERATION', 'info': "${widget.data['acceleration'].toString()} m/s²"},
                ]),
      
                const Divider(thickness: 3.5),
                
                FutureBuilder(
                  future: getUser(widget.data['user']),
                  builder: (context, snapshot) {

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
      
                    final snapData = snapshot.data.data();
    
                    return Column(
                      children: [
    
                        _buildInfo([
                          {'title': 'NAME', 'info': "${snapData['firstName']} ${snapData['lastName']}"},
                          {'title': 'AGE', 'info': '${snapData['age']} years old'},
                          {'title': 'GENDER', 'info': 'MALE'},
                          {'title': 'CONTACT NUMBER', 'info': snapData['contactNumber']},
                        ]),
    
                        const Divider(thickness: 3.5),
    
                        _buildMedicalInfo(snapData),
    
                      ],
                    );
      
                    
                  },
                ),
      
                const SizedBox(height: 50),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    

                    const SizedBox(height: 10),

                    BlocConsumer<EmergencyCubit, EmergencyState>(
                      listener: (context, state) {
                        if (state is EmergencyAccepted) {
                          EasyLoading.showSuccess("This emergency has been accepted successfully!")
                            .then((value) {
                              context.router.pop();
                            });
                        } else if (state is EmergencyResolved) {
                          EasyLoading.showSuccess("This emergency has been resolved!")
                            .then((value) {
                              context.router.pop();
                            });
                        }
                      },
                      builder: (context, state) {

                        if (state is EmergencyResolved) {
                          return const SizedBox();
                        }

                        if (state is EmergencyAccepted) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonButton(
                                onTap: () {
                                  launchGoogleMaps(widget.data['locationLat'], widget.data['locationLng']);
                                },
                                text: "TRACK LOCATION",
                              ),
                    
                              const SizedBox(width: 10),
                    
                              CommonButton(
                                onTap: () {
                                  context.read<EmergencyCubit>().resolveEmergency(widget.data['id']);
                                },
                                text: "RESOLVED!",
                                color: Colors.transparent,
                                textColor: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context.read<EmergencyCubit>().acceptEmergency(widget.data['id'], currentUserId);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.green,
                                ),
                                child: const Text("ACCEPT RESCUE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 19.0
                                  )
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                    
                    
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildInformation(placemark) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15, top: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(placemark.street ?? 'Loading...',
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 26
              ),
            ),
            Text("${placemark.locality ?? 'Loading...'}, ${placemark.administrativeArea ?? 'Loading...'}", overflow: TextOverflow.visible)
          ],
        ),
      )
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

  _buildMedicalInfo(userData) {

    if (userData['medicalInfo'] == null) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Medical Info Recorded",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    final medicalInfo = MedicalInformationModel.fromMap(userData['medicalInfo']);
    
    if (!medicalInfoShown) {
      return GestureDetector(
        onTap: () => setState(() {
          medicalInfoShown = true;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Show Medical Info",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_drop_down)
            ],
          ),
        ),
      );
    }
    
    return Column(
      children: [
        _buildInfo([
          {'title': 'BLOOD TYPE', 'info': medicalInfo.bloodType},
          {'title': 'WEIGHT', 'info': medicalInfo.weight},
          {'title': 'HEIGHT', 'info': medicalInfo.height},
          {'title': 'ALLERGIES', 'info': medicalInfo.allergies, 'isList': true},
          {'title': 'CURRENT MEDICATIONS', 'info': medicalInfo.currentMedications, 'isList': true},
          {'title': 'CHRONIC CONDITIONS', 'info': medicalInfo.chronicConditions, 'isList': true},
          {'title': 'CURRENT DISEASES', 'info': medicalInfo.currentDiseases, 'isList': true},
          {'title': 'PAST DISEASES', 'info': medicalInfo.pastDiseases, 'isList': true},
          {'title': 'PAST SURGERIES', 'info': medicalInfo.pastSurgeries, 'isList': true},
          {'title': 'IMMUNIZATION HISTORY', 'info': medicalInfo.immunizationHistory, 'isList': true},
          {'title': 'FAMILY MEDICAL HISTORY', 'info': medicalInfo.familyMedicalHistory, 'isList': true},
          {'title': 'PRIMARY CARE PHYSICIAN', 'info': medicalInfo.primaryCarePhysician, 'isList': true},
          {'title': 'ILLNESSES OR INFECTIONS', 'info': medicalInfo.recentIllnessesOrInfections, 'isList': true},
          {'title': 'RECENT TRAUMA', 'info': medicalInfo.recentTrauma, 'isList': true},
        ]),

        const SizedBox(height: 5),

        GestureDetector(
          onTap: () => setState(() {
            medicalInfoShown = false;
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Hide Medical Info",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_drop_up)
              ],
            ),
          ),
        )

      ],
    );

  }

}