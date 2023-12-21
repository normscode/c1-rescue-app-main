import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/presentation/state/edit_profile/edit_profile_cubit.dart';
import 'package:ralert/presentation/state/getself/getself_cubit.dart';

@RoutePage()
class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile",
          style: TextStyle(color: Colors.black)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is ProfileEditing) {
                EasyLoading.show(
                  status: 'Editing Profile...',
                  dismissOnTap: false,
                );
              } else if (state is ProfileEdited) {
                EasyLoading.showSuccess(
                  'Your profile has been updated successfully!',
                  dismissOnTap: false,
                );
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

                  firstNameController.text = snapshot.data!.firstName;
                  middleNameController.text = snapshot.data!.middleName ?? '';
                  lastNameController.text = snapshot.data!.lastName;
                  ageController.text = snapshot.data!.age;
                  contactNumberController.text = snapshot.data!.contactNumber;

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(
                                        "assets/images/profile_images/profile-screen-image.png"))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 10,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: const Icon(
                                  Icons.camera,
                                  size: 20.0,
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                  label: Text("First Name"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: middleNameController,
                              decoration: const InputDecoration(
                                  label: Text("Middle Name"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                  label: Text("Last Name"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                  label: Text("Age"),
                                  prefixIcon: Icon(Icons.person)),
                            ),
                            const SizedBox(height: 30 - 20),
                            TextFormField(
                              controller: contactNumberController,
                              decoration: const InputDecoration(
                                  label: Text("Contact Number"),
                                  prefixIcon: Icon(Icons.phone)),
                            ),
                            const SizedBox(height: 30 - 20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  UpdateProfileDto updateProfileDto = UpdateProfileDto(
                                    firstName: firstNameController.text,
                                    middleName: middleNameController.text,
                                    lastName: lastNameController.text,
                                    age: ageController.text,
                                    contactNumber: contactNumberController.text
                                  );

                                  context.read<EditProfileCubit>().updateUserProfile(updateProfileDto);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text("Edit Profile",
                                  style: TextStyle(color: Colors.black)
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      )
                    ],
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}