import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/verification/verification_cubit.dart';
import 'package:ralert/presentation/state/verification_process/verification_process_cubit.dart';
import 'package:ralert/presentation/widgets/transparent_button.widget.dart';

@RoutePage()
class VerificationProcessScreen extends StatefulWidget {
  const VerificationProcessScreen({super.key});

  @override
  State<VerificationProcessScreen> createState() =>
      _VerificationProcessScreenState();
}

class _VerificationProcessScreenState extends State<VerificationProcessScreen> {
  List<Widget> screens = [
    const WelcomeVerificationScreen(),
    const SelfieInfoVerificationScreen(),
    const SizedBox(),
    const IDInfoVerificationScreen(),
    const SizedBox(),
    const VideoFaceVerificationScreen(),
    const SizedBox(),
    const PendingVerificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/welcome_images/welcome_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SizedBox()),
          BlocConsumer<VerificationProcessCubit, VerificationProcessState>(
            listener: (context, state) {
              if (state.currentIndex == 2) {
                context.router.push(CameraRoute(captureType: 'selfie'));
              }

              if (state.currentIndex == 4) {
                context.router.push(CameraRoute(captureType: 'id'));
              }

              if (state.currentIndex == 6) {
                context.router.push(CameraRoute(captureType: 'video'));
              }

              if (state.currentIndex == 7) {
                context.read<VerificationCubit>().verifyUser();
              }
            },
            builder: (context, state) {
              return screens[state.currentIndex];
            },
          )
        ],
      )),
    );
  }
}

class WelcomeVerificationScreen extends StatelessWidget {
  const WelcomeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Welcome to Ralert!",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Icon(Icons.verified,
              size: 120, color: Theme.of(context).primaryColor),
          const Text(
            "We just need a few verification steps to start.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TransparentButton(
              text: "LET'S GO!",
              onTap: () {
                context.read<VerificationProcessCubit>().nextProcess();
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class SelfieInfoVerificationScreen extends StatelessWidget {
  const SelfieInfoVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Time to take a selfie!",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Icon(Icons.face, size: 120, color: Theme.of(context).primaryColor),
          const Text(
            "Remove your glasses, mask, hat and anything that covers your head and face, including heavy make-up.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TransparentButton(
              text: "Okay!",
              onTap: () {
                context.read<VerificationProcessCubit>().nextProcess();
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Future<String> artificialFuture() async {
  await Future.delayed(const Duration(milliseconds: 3500));
  return 'Data loaded successfully!';
}

class IDInfoVerificationScreen extends StatelessWidget {
  const IDInfoVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: artificialFuture(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              SizedBox(height: 20),
              Text("Submitting...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ));
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Success! Now, get your valid ID ready",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(Icons.card_giftcard_sharp,
                  size: 120, color: Theme.of(context).primaryColor),
              const Text(
                "Any valid PH IDs are accepted! Just make them clear.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              TransparentButton(
                  text: "Okay!",
                  onTap: () {
                    context.read<VerificationProcessCubit>().nextProcess();
                  }),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class VideoFaceVerificationScreen extends StatelessWidget {
  const VideoFaceVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: artificialFuture(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              SizedBox(height: 20),
              Text("Submitting...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ));
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "We're almost there!",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(Icons.video_file,
                  size: 120, color: Theme.of(context).primaryColor),
              const Text(
                "Take a 3-second video saying \"RALERT\". This can help us verify your identify fast.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              TransparentButton(
                  text: "Okay!",
                  onTap: () {
                    context.read<VerificationProcessCubit>().nextProcess();
                  }),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class PendingVerificationScreen extends StatelessWidget {
  const PendingVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: artificialFuture(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              SizedBox(height: 20),
              Text("Please wait...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ));
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Verification Pending",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(Icons.lock_clock,
                  size: 120, color: Theme.of(context).primaryColor),
              const Text(
                "Your details has been recorded and we are still reviewing it. This might take about 24 hours and please check your email for updates, please come back later. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              TransparentButton(
                  text: "Sign Out",
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    context.router.replaceAll([const AuthManagerRoute()]);
                  }),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}

class SuccessVerificationScreen extends StatelessWidget {
  const SuccessVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Verified successfully!",
            style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Icon(Icons.lock_clock,
              size: 120, color: Theme.of(context).primaryColor),
          const Text(
            "Congratulations! You are now verified. Welcome to Ralert! Let's keep you safe from car crash and accidents, 24/7.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          TransparentButton(
              text: "LET'S GO!",
              onTap: () {
                FirebaseAuth.instance.signOut();
                context.router.replaceAll([const AuthManagerRoute()]);
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
