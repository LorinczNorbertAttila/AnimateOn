import 'dart:io';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_compare/image_compare.dart';
import 'package:image_picker/image_picker.dart';
import 'images.dart';


  
Future getImage() async{
  var image1;
  final imagePicker = ImagePicker();

  final image = await imagePicker.pickImage(
    source: ImageSource.camera
  );
  if (image == null) return null;
  image1 = File(image.path);
  return image1;
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


Future<Images?> listStorage(var image) async {
  var _image = image;
  final storageRef = FirebaseStorage.instance.ref().child("samples/");
  final listResult = await storageRef.listAll();
  String imageUrl = '';
  var a = _image;
  var b, result, url;
  List<Images> images = [];
  for (var items in listResult.items) {
    try{
        imageUrl = await items.getDownloadURL();
      }catch(onError){
        print("Error");
      }
      b = Uri.parse(imageUrl);
      result = await compareImages(src1: a, src2: b, algorithm: EuclideanColorDistance());
      url = await items.getDownloadURL();
      images.add(Images(items.name, result, url));
  }
  double min = 10;
  for (var items in images){
    if(items.match < min){
      min = items.match;
    }
  }
  for (var items in images){
    if(items.match == min){
      return items;
    }
  }
  return null;

}