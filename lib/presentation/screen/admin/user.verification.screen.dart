
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class _UserVerificationScreenState extends State<UserVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Verification Info")
      ),
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
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Identification Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
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
                      builder: (_) => ImageDialog(widget.verification['selfieUrl'])
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.6),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("See User Face Picture",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        
                        Icon(Icons.keyboard_arrow_right, size: 35)
                      ],
                    )
                  ),
                ),

                const SizedBox(height: 10),
          
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => ImageDialog(widget.verification['idUrl'])
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.6),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("See User Valid ID",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        
                        Icon(Icons.keyboard_arrow_right, size: 35)
                      ],
                    )
                  ),
                ),

                const SizedBox(height: 10),
          
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) => VideoDialog(widget.verification['videoUrl'])
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.6),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("See Video",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        
                        Icon(Icons.keyboard_arrow_right, size: 35)
                      ],
                    )
                  ),
                ),

                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        context.read<AdminCubit>().verify(widget.user['id']);
                        
                        context.read<AdminCubit>().getAdminAnalytics();
                        context.router.replaceAll([const AuthManagerRoute()]);
                        
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.greenAccent
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Verify",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            
                            Icon(Icons.keyboard_arrow_right, size: 35)
                          ],
                        )
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        context.read<AdminCubit>().deny(widget.user['id']);
                        context.router.pop();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.redAccent
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Cancel",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            
                            Icon(Icons.keyboard_arrow_right, size: 35)
                          ],
                        )
                      ),
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
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover
          )
        ),
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

    _controller = VideoPlayerController.networkUrl(Uri.parse(
        widget.url))
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
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: !_controller.value.isPlaying ? const Icon(Icons.play_arrow) : const Icon(Icons.stop_sharp),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container()
    );
  }
}
