import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: kToolbarHeight),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.router.replaceAll([const AuthManagerRoute()]);
            },
            title: const Text("Logout"),
            trailing: const Icon(
              Icons.logout,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
