import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

List<CameraDescription> cameras = [];
bool _isFrontCamera = true;
bool _isRecording = false;
bool _isSaving = false;
String filePath = "";

class ColorPage extends StatelessWidget {
  static const routeName = '/color';

  const ColorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String selectedColor = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Container(child: Demo()),
        color: _getColorFromOption(selectedColor)        
      ),
    );
  }

  Color _getColorFromOption(String option) {
    switch (option) {
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Blue':
        return Colors.blue;
      case 'Yellow':
        return Colors.yellow;
      case 'Black':
        return Colors.black;
      case 'Orange':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}

class Demo extends StatelessWidget {
  build(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, right: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Visibility(
              visible: _isSaving,
              child: Positioned(                
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                    height: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0x20051C48),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Guardando video...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: 150,
                height: 330,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.transparent),
                ),
                // margin: EdgeInsets.only(bottom: 30),
                child: Square(),
              ),
            ),
          ),
          
          // Square(),
        ],
      ),
    );
  }
}

class Square extends StatefulWidget {
  final color;
  final size;

  Square({this.color, this.size});

  @override
  _SquareState createState() => _SquareState();
}

class _SquareState extends State<Square> {
  late CameraController controller;

  @override
  void initState() {
    //loadCamera();
    super.initState();
    _isFrontCamera = true;
    _isRecording = false;
    _isSaving = false;
    
    if(_isFrontCamera) {
        controller = CameraController(cameras![1], ResolutionPreset.max);
    }else{
      controller = CameraController(cameras![0], ResolutionPreset.max);
    }
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  loadCamera() async {
    if(_isFrontCamera) {
        controller = CameraController(cameras![1], ResolutionPreset.max);
    }else{
      controller = CameraController(cameras![0], ResolutionPreset.max);
    }
    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  _recordVideo() async {
    if (_isRecording) {
      setState(() => _isSaving = true);
      final file = await controller?.stopVideoRecording();
      filePath = file!.path;
      print(filePath);
      await GallerySaver.saveVideo(filePath);
      File(filePath).deleteSync();
      setState(() => _isRecording = false);
      setState(() => _isSaving = false);
    } else {
      await controller?.prepareForVideoRecording();
      await controller?.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Container(
      child: AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: [
            CameraPreview(controller),
            Visibility(
              visible: !_isRecording,
              child: Positioned(
                right: 0,
                bottom: 0,
                child: Align(
                  // alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 55,
                    height: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(88, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                  _isFrontCamera = !_isFrontCamera;
                                  loadCamera();
                              },
                              icon: Image.asset('assets/back.png',),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Positioned(
                left: 0,
                bottom: 0,
                child: Align(
                  // alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 55,
                    height: 55,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(88, 255, 255, 255),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                  _recordVideo();
                              },
                              icon: _isRecording ? Image.asset('assets/stop.png') : Image.asset('assets/rec.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ) 
      )
    );
  }
}
