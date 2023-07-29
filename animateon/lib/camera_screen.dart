import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_compare/image_compare.dart';
import 'package:image_picker/image_picker.dart';
import 'images.dart';


var _image;
final imagePicker = ImagePicker();

Future getImage() async{
  final image = await imagePicker.pickImage(
    source: ImageSource.camera
  );
  if (image == null) return;
  _image = File(image.path);
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraScreen> {
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
    final size = MediaQuery.of(context).size;
    try{

  return Scaffold(
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
      body: SizedBox(
              width: size.width,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                    width: 100, // the actual width is not important here
                    child: CameraPreview(cameraController)),
              )));
  }catch(e){
    return SizedBox();
  }
  }
}

void listStorage() async {
  final storageRef = FirebaseStorage.instance.ref().child("samples/");
  final listResult = await storageRef.listAll();
  String imageUrl = '';
  var a = Uri.parse('https://media.npr.org/assets/img/2012/02/02/mona-lisa_custom-31a0453b88a2ebcb12c652bce5a1e9c35730a132.jpg');
  var b, result;
  List<Images> images = [];
  for (var items in listResult.items) {
    try{
        imageUrl = await items.getDownloadURL();
      }catch(onError){
        print("Error");
      }
      b = Uri.parse(imageUrl);
      result = await compareImages(src1: a, src2: b, algorithm: PerceptualHash());
      images.add(Images(items.fullPath, result));
  }
  double min = 10;
  for (var items in images){
    if(items.match < min){
      min = items.match;
    }
  }
  for (var items in images){
    if(items.match == min){
      var name = items.name;
     print('\x1B[31m $name \x1B[0m');
    }
  }
}