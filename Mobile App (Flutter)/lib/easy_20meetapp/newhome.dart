import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import '../main.dart';


class Newhome extends StatefulWidget {
  const Newhome({Key? key}) : super(key: key);

  @override
  State<Newhome> createState() => _NewhomeState();
}

class _NewhomeState extends State<Newhome> {
  bool isWorking = false;
  String result = '';
  late CameraController cameraController;
  CameraImage? imgCamera;
  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/ssd_mobilenet.tflite", labels: "assets/model/ssd_mobilenet.txt");
  }

  // = Null as CameraImage;
  InitCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imagesFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imagesFromStream,
                  runModelOnStreamFrames(),
                }
            });
      });
    });
  }

  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var recogntion = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result = "";
      recogntion!.forEach((response) {
        result += response["label"] +
            " " +
            (response["confidence"] as double).toStringAsFixed(2) +
            "\n\n";
      });
      setState(() {
        result;
      });
      isWorking = false;
    }
  }

  void initState() {
    super.initState();
    loadModel();
  }

  void dispose() async {
    super.dispose();
    await Tflite.close();
    cameraController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        body: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        color: Colors.black,
                        height: 320,
                        width: 330,
                        // child: Image.asset("img2.jpg"),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          InitCamera();
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 35),
                            height: 270,
                            width: 330,
                            child: imgCamera == null
                                ? Container(
                                    height: 270,
                                    width: 360,
                                    child: Icon(
                                      Icons.photo_camera_front,
                                      color: Colors.blueAccent,
                                      size: 40,
                                    ),
                                  )
                                : AspectRatio(
                                    aspectRatio:
                                        cameraController.value.aspectRatio,
                                    child: CameraPreview(cameraController),
                                  )),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 55),
                    child: SingleChildScrollView(
                      child: Text(
                        result,
                        style: TextStyle(
                            backgroundColor: Colors.black87,
                            fontSize: 30,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img2.jpg")))),
      )),
    );
  }
}
