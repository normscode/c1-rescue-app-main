import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/presentation/state/getself/getself_cubit.dart';
import 'package:ralert/presentation/widgets/profilemenu.widget.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder<UserEntity?>(
            future: context.read<GetselfCubit>().fetchUser(),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

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
                              Icons.edit,
                              size: 20.0,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                    style: const TextStyle(
                      color: Colors.black
                    )
                  ),
                  Text(snapshot.data!.email,
                    style: const TextStyle(
                      color: Colors.black
                    )
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        context.router.push(const UpdateProfileRoute());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text("Edit Profile",
                        style: TextStyle(
                          color: Colors.black
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),

                  ////Menu
                  snapshot.data?.userType == "user"
                    ? ProfileMenuWidget(
                      title: "Medical Information",
                      icon: Icons.medical_information,
                      onPress: () {
                        context.router.push(const MedicalInfoRoute());
                      })
                    : const SizedBox(),
                  ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.exit_to_app,
                    endIcon: false,
                    onPress: () {
                      FirebaseAuth.instance.signOut();
                      context.router.replaceAll([const AuthManagerRoute()]);
                    },
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
