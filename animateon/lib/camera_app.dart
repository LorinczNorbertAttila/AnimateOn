import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Camera_app extends StatefulWidget {
  const Camera_app({super.key});

  @override
  State<Camera_app> createState() => _Camera_appState();
}

class _Camera_appState extends State<Camera_app> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Animate On',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'LilitaOne',
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[300],
        ),
        body: Stack(children: [
          CameraPreview(cameraController),
        ]),
      );
    } else {
      return const SizedBox();
    }
  }
}
