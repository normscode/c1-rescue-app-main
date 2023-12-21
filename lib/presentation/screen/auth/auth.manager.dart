import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/screen/admin/admintools.screen.dart';
import 'package:ralert/presentation/screen/main/main.screen.dart';
import 'package:ralert/presentation/screen/onboarding/welcome.dart';
import 'package:ralert/presentation/screen/verification/verification.process.screen.dart';
import 'package:ralert/presentation/state/usercheck/usercheck_cubit.dart';
import 'package:ralert/presentation/state/verification/verification_cubit.dart';
import 'package:ralert/presentation/state/verification_process/verification_process_cubit.dart';
import 'package:ralert/core/global/global.variable.dart';

@RoutePage()
class AuthManagerScreen extends StatefulWidget {
  const AuthManagerScreen({super.key});

  @override
  State<AuthManagerScreen> createState() => _AuthManagerScreenState();
}

class _AuthManagerScreenState extends State<AuthManagerScreen> {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

  @override
  void initState() {
    super.initState();

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((NotificationAppLaunchDetails? notificationAppLaunchDetails) {
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {

          final payload = response.payload?.split('/');

          if (payload![0] == 'alert-sent') {
            context.router.push(SOSRoute(alertSent: true, fromCarCrash: true));
          } else {
            context.router.push(SOSRoute(startingDuration: int.parse(payload[1]), fromCarCrash: true));
          }

        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsercheckCubit, UsercheckState>(
      builder: (context, state) {
        if (state is Authenticating) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is UnAuthenticated) {
          return const WelcomeScreen();
        } else if (state is Authenticated) {
          
          return FutureBuilder(
            future: getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              final userType = snapshot.data['userType'];

              if (userType == 'admin') {
                return const AdminScreen();
              }

              return FutureBuilder(
                future: context.read<VerificationCubit>().getVerificationStatus(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snap) {
                  
                  if (!snap.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                                      
                  if (snap.data == 'verified') {
                    if (userType == 'rescuer') {
                      return const MainScreen(userType: "rescuer");
                    } else {
                      return const MainScreen(userType: "user");
                    }
                  } else if (snap.data == 'verifying') {
                    context.read<VerificationProcessCubit>().setProcess(7);

                    return const VerificationProcessScreen();
                  } else {
                    return const VerificationProcessScreen();
                  }

                }
              );

              

            },
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }
      },
    );
  }

}