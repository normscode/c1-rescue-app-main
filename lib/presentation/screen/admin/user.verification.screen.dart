import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/hotmail.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/admin/admin_cubit.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class UserVerificationScreen extends StatefulWidget {
  const UserVerificationScreen(this.verification, this.user, {super.key});

  final dynamic verification;
  final dynamic user;

  @override
  State<UserVerificationScreen> createState() => _UserVerificationScreenState();
}

final outlookSmtp =
    hotmail(dotenv.env["OUTLOOK_EMAIL"]!, dotenv.env["OUTLOOK_PASSWORD"]!);
Future<void> sendMailFromOutlook(String userEmail) async {
  final message = Message()
    ..from = Address(dotenv.env["OUTLOOK_EMAIL"]!, 'Verification Ralert App')
    ..recipients.add(userEmail)
    ..subject =
        'Account Verification Successful – Welcome to Ralert! :: 😀 :: ${DateTime.now()}'
    ..text =
        "Great news! Your Ralert account has been successfully verified, and you are now all set to enjoy the full benefits of our service.\nWe appreciate your prompt action in completing the verification process. Your commitment to account security helps us ensure a safe and reliable experience for all our users.\n If you have any questions, concerns, or if there's anything else we can assist you with, feel free to reach out to our support team at [ralert2023@outlook.com]. We're here to help!";
  // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, outlookSmtp);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}

class _UserVerificationScreenState extends State<UserVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Verification Info")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(225, 224, 225, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Identification Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text('First name: ${widget.user['firstName']}'),
                      Text('Last name: ${widget.user['lastName']}'),
                      Text('Contact number: ${widget.user['contactNumber']}'),
                      Text('Type: ${widget.user['userType']}'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            ImageDialog(widget.verification['selfieUrl']));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See User Face Picture",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 35)
                        ],
                      )),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            ImageDialog(widget.verification['idUrl']));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See User Valid ID",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 35)
                        ],
                      )),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) =>
                            VideoDialog(widget.verification['videoUrl']));
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.6),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "See Video",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 35)
                        ],
                      )),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        context.read<AdminCubit>().verify(widget.user['id']);
                        String? userEmail =
                            await getUserEmail(widget.user['id']);
                        if (userEmail != null) {
                          // Send verification email
                          await sendMailFromOutlook(userEmail);
                        } else {
                          print('User email not found or user not found.');
                        }
                        await getUserEmail(widget.user['id']);
                        context.read<AdminCubit>().getAdminAnalytics();
                        context.router.replaceAll([const AuthManagerRoute()]);
                        widget.user['id'];
                        setState(() {});
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.greenAccent),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Verify",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.keyboard_arrow_right, size: 35)
                            ],
                          )),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        context.read<AdminCubit>().deny(widget.user['id']);
                        context.router.pop();
                        setState(() {});
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.redAccent),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cancel",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Icon(Icons.keyboard_arrow_right, size: 35)
                            ],
                          )),
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
}

class ImageDialog extends StatelessWidget {
  final String url;

  const ImageDialog(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
      ),
    );
  }
}

class VideoDialog extends StatefulWidget {
  final String url;

  const VideoDialog(this.url, {super.key});

  @override
  State<VideoDialog> createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    Positioned(
                      bottom: 30,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: !_controller.value.isPlaying
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.stop_sharp),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container());
  }
}

Future<String?> getUserEmail(String userID) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(userID).get();

    if (userSnapshot.exists) {
      // User document exists, get the email
      String email = userSnapshot['email'];

      // Print the email for testing
      print('User Email: $email');

      // Return the email
      return email;
    } else {
      // User document doesn't exist
      print('User not found.');
      return null;
    }
  } catch (e) {
    // Handle any errors that occurred during the fetch
    print('Error fetching user data: $e');
    return null;
  }
}
