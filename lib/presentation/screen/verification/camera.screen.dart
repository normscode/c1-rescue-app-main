import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/presentation/state/storage_image/storage_image_cubit.dart';
import 'package:ralert/presentation/state/verification_process/verification_process_cubit.dart';

@RoutePage()
class CameraScreen extends StatefulWidget {
  const CameraScreen(this.captureType, {super.key});

  final String captureType;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late CameraController _controller;
  late dynamic user;
  
  bool cameraInitialized = false;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();

    startCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      widget.captureType == 'id' ? cameras[0] : cameras[1],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller.initialize();
      
    if (!mounted) {
      return;
    }

    setState(() {
      cameraInitialized = true;
    });

  }


  @override
  Widget build(BuildContext context) {

    if (!cameraInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<StorageImageCubit, StorageImageState>(
          listener: (context, state) {
            if (state is Uploading) {
              EasyLoading.show(
                status: 'Please wait...',
                dismissOnTap: false,
              );
            } else if (state is Uploaded) {
              EasyLoading.dismiss();
              
              context.read<VerificationProcessCubit>().nextProcess();
              Navigator.of(context).pop();
              context.router.pop();

            }
          },
          builder: (context, state) {
            return Stack(
              fit: StackFit.loose,
              children: [
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller)
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () async {
                        if (widget.captureType == 'video') {
                          processVideo();
                        } else {
                          final image = await _controller.takePicture();
                        
                          upload(image);
                        }
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: !isRecording ? Colors.white : Colors.redAccent
                        ),
                        child: Icon(Icons.camera, color: !isRecording ? Colors.black : Colors.white)
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      )
    );
  }

  Future<void> upload(file) async {

    _controller.pausePreview();

    Widget okButton = TextButton(
      onPressed: () {
        context.read<StorageImageCubit>().onUploadToStorage(
          file: file,
          path:"user_verification/${FirebaseAuth.instance.currentUser!.uid}/${widget.captureType}.${widget.captureType == 'video' ? 'mp4' : 'png'}"
        );
      },
      child: const Text("OK"),
    );

    Widget cancelButton = TextButton(
      onPressed: () {
        _controller.resumePreview();
        Navigator.of(context).pop();
      },
      child: const Text("CANCEL"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Submit your ${widget.captureType}"),
      content: const Text("Please make sure that it's not blurred and has no hidden text so that we can review your verification as fast as possible."),
      actions: [
        cancelButton,
        okButton
      ],
    );

    // show the dialog
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  processVideo() async {
    if (isRecording) {
      final file = await _controller.stopVideoRecording();

      setState(() => isRecording = false);

      upload(file);
    } else {
      await _controller.prepareForVideoRecording();
      await _controller.startVideoRecording();

      setState(() => isRecording = true);
    }
  }
}