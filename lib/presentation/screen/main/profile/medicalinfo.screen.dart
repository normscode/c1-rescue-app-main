import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/global/alert.dialog.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/presentation/state/getself/getself_cubit.dart';
import 'package:ralert/presentation/state/medical_info/medical_info_cubit.dart';

@RoutePage()
class MedicalInfoScreen extends StatefulWidget {
  const MedicalInfoScreen({super.key});

  @override
  State<MedicalInfoScreen> createState() => _MedicalInfoScreenState();
}

class _MedicalInfoScreenState extends State<MedicalInfoScreen> { 

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return showAlertDialog(
          context: context,
          title: "Are you sure you want to go back?",
          content: "Your changes won't be saved.",
          onTap: () {
            Navigator.pop(context, true);
          },
          onCancel: () {
            Navigator.pop(context, false);
          }
        );

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Medical Information",
            style: TextStyle(color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocConsumer<MedicalInfoCubit, MedicalInfoState>(
              listener: (context, state) {
                if (state is MedicalInfoSaving) {
                  EasyLoading.show(
                    status: 'Saving Medical Information',
                    dismissOnTap: false,
                  );
                } else if (state is MedicalInfoSaved) {
                  EasyLoading.showSuccess(
                    'Medical information has been saved successfully!',
                    dismissOnTap: false,
                  ).then((value) {
                    context.router.pop();
                    Navigator.pop(context, true);
                  });
                }
              },
              builder: (context, state) {
                return FutureBuilder<UserEntity?>(
                  future: context.read<GetselfCubit>().fetchUser(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    
                    return MedicalInfoForm(snapshot.data);
                    
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  
}

class MedicalInfoForm extends StatefulWidget {
  const MedicalInfoForm(this.data, {super.key});

  final data;

  @override
  State<MedicalInfoForm> createState() => _MedicalInfoFormState();
}

class _MedicalInfoFormState extends State<MedicalInfoForm> {

  late dynamic medicalInformation;

  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  List<dynamic> contacts = [];
  List<dynamic> allergies = [];
  List<dynamic> currentMedications = [];
  List<dynamic> chronicConditions = [];
  List<dynamic> currentDiseases = [];
  List<dynamic> pastDiseases = [];
  List<dynamic> pastSurgeries = [];
  List<dynamic> immunizationHistory = [];
  List<dynamic> familyMedicalHistory = [];
  List<dynamic> primaryCarePhysician = [];
  List<dynamic> recentIllnessesOrInfections = [];
  List<dynamic> recentTrauma = [];

  final TextEditingController insuranceProviderController = TextEditingController();
  final TextEditingController policyNumberController = TextEditingController();
  final TextEditingController groupNumberController = TextEditingController();

  final TextEditingController workplaceController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();

  @override
  void initState() {

    medicalInformation = widget.data?.medicalInfo;
    
    if (medicalInformation != null) {
      bloodTypeController.text = medicalInformation.bloodType!;
      heightController.text = medicalInformation.height!;
      weightController.text = medicalInformation.weight!;

      setupAndCheckRebuildDuplications();
      
      insuranceProviderController.text = medicalInformation.insuranceProvider!;
      policyNumberController.text = medicalInformation.policyNumber!;
      groupNumberController.text = medicalInformation.groupNumber!;

      workplaceController.text = medicalInformation.workplace!;
      schoolController.text = medicalInformation.school!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                _buildPersonalInformation(),
                _buildEmergencyContact(),
                _buildMedicalHistory(),
                _buildInsuranceInformation(),
              ],
            ),
          ),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {

                MedicalInfoDto medicalInfoDto = MedicalInfoDto(
                  bloodType: bloodTypeController.text,
                  height: heightController.text,
                  weight: weightController.text,
                  emergencyContacts: contacts,
                  allergies: allergies,
                  currentMedications: currentMedications,
                  chronicConditions: chronicConditions,
                  currentDiseases: currentDiseases,
                  pastDiseases: pastDiseases,
                  pastSurgeries: pastDiseases,
                  immunizationHistory: immunizationHistory,
                  familyMedicalHistory: familyMedicalHistory,
                  primaryCarePhysician: primaryCarePhysician,
                  recentIllnessesOrInfections: recentIllnessesOrInfections,
                  recentTrauma: recentTrauma,
                  insuranceProvider: insuranceProviderController.text,
                  policyNumber: policyNumberController.text,
                  groupNumber: groupNumberController.text,
                  workplace: workplaceController.text,
                  school: schoolController.text
                );

                context.read<MedicalInfoCubit>().editMedicalInfo(medicalInfoDto: medicalInfoDto);

              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  side: BorderSide.none,
                  shape: const StadiumBorder()),
              child: const Text("Save Medical Info",
                  style: TextStyle(color: Colors.black)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  setupAndCheckRebuildDuplications() {
    for (var i in medicalInformation.emergencyContacts!) {
      if (!contacts.contains(i)) contacts.add(i);
    }
    for (var i in medicalInformation.allergies!) {
      if (!allergies.contains(i)) allergies.add(i);
    }
    for (var i in medicalInformation.currentMedications!) {
      if (!currentMedications.contains(i)) currentMedications.add(i);
    }
    for (var i in medicalInformation.chronicConditions!) {
      if (!chronicConditions.contains(i)) chronicConditions.add(i);
    }
    for (var i in medicalInformation.currentDiseases!) {
      if (!currentDiseases.contains(i)) currentDiseases.add(i);
    }
    for (var i in medicalInformation.pastDiseases!) {
      if (!pastDiseases.contains(i)) pastDiseases.add(i);
    }
    for (var i in medicalInformation.pastSurgeries!) {
      if (!pastSurgeries.contains(i)) pastSurgeries.add(i);
    }
    for (var i in medicalInformation.immunizationHistory!) {
      if (!immunizationHistory.contains(i)) immunizationHistory.add(i);
    }
    for (var i in medicalInformation.familyMedicalHistory!) {
      if (!familyMedicalHistory.contains(i)) familyMedicalHistory.add(i);
    }
    for (var i in medicalInformation.primaryCarePhysician!) {
      if (!primaryCarePhysician.contains(i)) primaryCarePhysician.add(i);
    }
    for (var i in medicalInformation.recentIllnessesOrInfections!) {
      if (!recentIllnessesOrInfections.contains(i)) recentIllnessesOrInfections.add(i);
    }
    for (var i in medicalInformation.recentTrauma!) {
      if (!recentTrauma.contains(i)) recentTrauma.add(i);
    }
  }

  _buildPersonalInformation() {
    return Column(
      children: [
        _buildTitle("PERSONAL INFORMATION"),

        TextFormField(
          controller: bloodTypeController,
          decoration: const InputDecoration(
              label: Text("Blood Type"),
              prefixIcon: Icon(Icons.bloodtype)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: heightController,
          decoration: const InputDecoration(
              label: Text("Height (ft)"),
              prefixIcon: Icon(Icons.height)),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: weightController,
          decoration: const InputDecoration(
              label: Text("Weight (kg)"),
              prefixIcon: Icon(Icons.line_weight)),
        ),
      ],
    );
  }

  _buildEmergencyContact() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: _buildListInfo("Emergency Contact Numbers", contacts, const Icon(Icons.contact_emergency)),
    );
  }

  _buildMedicalHistory() {
    return Column(
      children: [
        _buildTitle("Medical History"),

        _buildListInfo("Allergies", allergies, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Current Medications", currentMedications, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Chronic Conditions", chronicConditions, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Current Diseases", currentDiseases, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Past Diseases", pastDiseases, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Past Surgeries", pastSurgeries, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Immunization History", immunizationHistory, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Family Medical History", familyMedicalHistory, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Primary Care Physician", primaryCarePhysician, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Recent Illnesses or Infections", recentIllnessesOrInfections, const Icon(Icons.medical_information_sharp)),
        _buildListInfo("Recent Trauma", recentTrauma, const Icon(Icons.medical_information_sharp)),
        const SizedBox(height: 10),
      ],
    );
  }

  _buildInsuranceInformation() {
    return Column(
      children: [
        _buildTitle("INSURANCE INFORMATION"),

        const SizedBox(height: 10),
        TextFormField(
          controller: insuranceProviderController,
          decoration: const InputDecoration(
              label: Text("Insurance Provider"),
              prefixIcon: Icon(Icons.safety_check)),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: policyNumberController,
          decoration: const InputDecoration(
              label: Text("Policy Number"),
              prefixIcon: Icon(Icons.numbers)),
        ),

        const SizedBox(height: 10),
        TextFormField(
          controller: groupNumberController,
          decoration: const InputDecoration(
              label: Text("Group Number"),
              prefixIcon: Icon(Icons.group_work)),
        ),
      ],
    );
  }

  _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20
        ),
      ),
    );
  }

  _buildListInfo(String editType, List<dynamic> where, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(editType,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 3),
          ListView.builder(
            shrinkWrap: true,
            itemCount: where.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("• ${where[i]}",
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          where.removeAt(i);
                        });
                      },
                      child: const Icon(Icons.delete),
                    )
                  ],
                )
              );
            },
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              context.router
                .push<dynamic>(AddToListRoute(editType: editType))
                .then((result) {

                  if (result == null) return;

                  if (result.isNotEmpty) {
                    setState(() {
                      where.add(result!);
                    });
                  }
              });
            },
            child: IgnorePointer(
              child: TextField(
                decoration: InputDecoration(
                    label: Text("Add $editType")),
              ),
            ),
          ),
          
        ],
      )
    );
  }
}