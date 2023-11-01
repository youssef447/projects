import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class CameraPage extends StatefulWidget {
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  //var urlGet = Uri.parse('http://192.168.1.11:5000/getId');
  var urlPost = Uri.parse('http://192.168.1.11:5000/postImage');

  String jsonResult;
  String empName;
  String id;
  CameraController _camera;
  CameraLensDirection _direction = CameraLensDirection.back;
  bool arrived = false;

  bool _faceFound = false;
  // bool _isTakingPic = false;
  bool _isDetecting = false;

  final FaceDetector _faceDetector = FirebaseVision.instance.faceDetector(
    const FaceDetectorOptions(
      mode: FaceDetectorMode.accurate,
    ),
  );
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    _camera.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  void restart() async {
    CameraDescription description = await getCamera(_direction);
    ImageRotation rotation =
        rotationIntToImageRotation(description.sensorOrientation);
    _camera.startImageStream((CameraImage image) async {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        //_isTakingPic=true;
        _faceDetector
            .processImage(
          FirebaseVisionImage.fromBytes(
            image.planes[0].bytes,
            buildMetaData(image, rotation),
          ),
        )
            .then(
          (dynamic result) async {
            if (result.length == 0) {
              _faceFound = false;
            } else {
              _faceFound = true;

              await _camera.stopImageStream();
              XFile file = await _camera.takePicture();

              String imagePath = file.path;
              sendImage(imagePath);
              /* await _camera.dispose();

              setState(() {
                _camera = null;
              });

              _initializeCamera(); */
              //_initializeCamera();
              // _camera.dispose();
              //Navigator.of(context).pop();
            }

            _isDetecting = false;
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

  Future<void> _initializeCamera() async {
    CameraDescription description = await getCamera(
        _direction); //description back from list of descriptions

    ImageRotation rotation =
        rotationIntToImageRotation(description.sensorOrientation);

    _camera = CameraController(description, ResolutionPreset.high,
        enableAudio: false);

    _camera.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
    await Future.delayed(const Duration(milliseconds: 500));

    _camera.startImageStream((CameraImage image) async {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        //_isTakingPic=true;
        _faceDetector
            .processImage(
          FirebaseVisionImage.fromBytes(
            image.planes[0].bytes,
            buildMetaData(image, rotation),
          ),
        )
            .then(
          (dynamic result) async {
            if (result.length == 0) {
              _faceFound = false;
            } else {
              _faceFound = true;

              await _camera.stopImageStream();
              XFile file = await _camera.takePicture();

              String imagePath = file.path;
              sendImage(imagePath);
              /* await _camera.dispose();

              setState(() {
                _camera = null;
              });

              _initializeCamera(); */
              //_initializeCamera();
              // _camera.dispose();
              //Navigator.of(context).pop();
            }

            _isDetecting = false;
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

  Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  ImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }

  FirebaseVisionImageMetadata buildMetaData(
    CameraImage image,
    ImageRotation rotation,
  ) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  Widget _body() {
    if (_camera == null || !_camera.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(alignment: Alignment.topRight, children: [
      Container(
        constraints: const BoxConstraints.expand(),
        child: CameraPreview(_camera),
      ),
      Positioned(
        top: 50,
        child: IconButton(
            onPressed: () {
              _toggleCamera();
            },
            icon: const Icon(
              Icons.cameraswitch_rounded,
              color: Color(0XFF2c255c),
            )),
      )
    ]);
  }

  void _toggleCamera() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }
    if (_camera.value.isStreamingImages) {
      await _camera.stopImageStream();
    }
    //await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  void sendImage(String imagePath) async {
    /*   Uint8List imgBytes = img.planes[0].bytes; // pixel data
XFile imgg = XFile.fromData(imgBytes); 
Directory dir = await getApplicationDocumentsDirectory();
String dirName = dir.path;
String imgPath = dirName + "/Img.jpg";
imgg.saveTo(imgPath);
await http.post(urlPost,body:json.encode({'imgpath':imgPath})); */
    File file = File(imagePath);
    //final headers={"Content-type":"multipart/form-data"};
    var request = http.MultipartRequest('POST', urlPost);
    request.files.add(
      http.MultipartFile(
          'image', file.readAsBytes().asStream(), file.lengthSync(),
          filename: imagePath.split('/').last),
    );
    //request.headers.addAll(headers);
    DateTime now = DateTime.now();

    String arrivalTime = DateFormat('kk:mm:a').format(now);

    var res = await request.send();

    var response = await http.Response.fromStream(res);
    dynamic decoded = json.decode(response.body);
    jsonResult = decoded['nameid'];
    List<String> result = jsonResult.split(',');
    empName = result[0];
    if(empName!="unknown"){
    print("idddddddddddddddddddd");
    print(result[1]);
    id = result[1];
    await Attendemp(id, arrivalTime, now);

    BuildContext dialogContext;
    showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0XFF2c255c),
        builder: (context) {
          dialogContext = context;

          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 200,
                child: Center(
                  child: FittedBox(
                    child: Text(
                      "Welcome,  " + empName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                  top: -80,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 60,
                    child: Icon(
                      Icons.done_all_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  )),
            ],
          );
        

          /* return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              backgroundColor: const Color(0XFF2c255c),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      SizedBox(
                        height: 200,
                        child: Center(
                          child: FittedBox(
                            child: Text(
                              "Welcome,  " +
                                  empName ,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                          top: -80,
                          child: CircleAvatar(
                            backgroundColor: Colors.purple,
                            radius: 60,
                            child: Icon(
                              Icons.done_all_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                          )),
                    ],
                  ),
                ],
              )

              //child: Text("Welcome " + empName+ " Your Id Is "+id+"   :)))"),

              ); */
        });
    await Future.delayed(const Duration(milliseconds: 4000));

    Navigator.pop(dialogContext);
    //await Future.delayed(const Duration(milliseconds: 3000));

    //_camera = null;
    await Future.delayed(const Duration(milliseconds: 8000));
    }

    restart();
    /*setState(() {
      _camera = null;
    });*/
  }

  Attendemp(String emp_id, String arrivalTime, DateTime now) async {
       int day = now.day;
      int month = now.month;
      int year = now.year;
    if (!arrived) {
      String tmp=arrivalTime;
      List<String> data=[];
      arrived = true;
      if (now.isBefore(DateFormat('yyyy-MM-dd kk:mm:a')
          .parse("$year-$month-$day 08:00:AM"))){
              tmp="08:00:AM";
            
          }
          else if(now.isBefore(DateFormat('yyyy-MM-dd kk:mm:a')
          .parse("$year-$month-$day 09:00:AM"))){
                            tmp="09:00:AM";


          }

           else if(now.isBefore(DateFormat('yyyy-MM-dd kk:mm:a')
          .parse("$year-$month-$day 10:00:AM"))){
                            tmp="10:00:AM";


          }
          else if(now.isBefore(DateFormat('yyyy-MM-dd kk:mm:a')
          .parse("$year-$month-$day 11:00:AM"))){
                            tmp="11:00:AM";


          }
          else{

            tmp="late";
          }
         
      DocumentReference empRef =
          FirebaseFirestore.instance.collection("employees").doc(emp_id);
          String n="${now.day.toString()}d";
      DocumentReference empRef2 = FirebaseFirestore.instance
          .collection("attendance")
          .doc(n);

        /* await empRef2.update({
          tmp: data,
        });   */ 
     
        var getdoc = await empRef2.get();

        data = getdoc[tmp].cast<String>() ?? [];
            var getdoc2 = await empRef.get();

        data.add(getdoc2.get('image url'));
        print('adddddddddeeeeeeeeeeed');
        await empRef2.update({
          tmp: data,
        });
       

      // if first day of month then we restart counting from 1 as we look at each month performance
      if (now.day == 1) {
        empRef.update({
          "arrivalTime": arrivalTime,
          "attended": 0,
        });
      } else {
        int old;
        var getdoc = await empRef.get();
        if (getdoc.exists) {
          old = getdoc['attended'];
        }
        int newval = old + 1;
        empRef.update({
          "arrivalTime": arrivalTime,
          "attended": newval,
        });
      }
   
      if (now.isAfter(DateFormat('yyyy-MM-dd kk:mm:a')
          .parse("$year-$month-$day 11:00:AM"))) {
        int late;

        var getdoc = await empRef.get();
        if (getdoc.exists) {
          late = getdoc['late'];
          late = late + 1;
        }
        empRef.update({
          "late": late,
        });
      }
    }
    //DateTime date=DateTime.now();
    //String threshold="${date.day.toString()} ${date.month.toString()} ${date..toString()} ";
  }
  /* void startStream(ImageRotation rotation)async {
         await Future.delayed(const Duration(milliseconds: 3000));

    _camera.startImageStream((CameraImage image) async {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        _faceDetector
            .processImage(
          FirebaseVisionImage.fromBytes(
            image.planes[0].bytes,
            buildMetaData(image, rotation),
          ),
        )
            .then(
          (dynamic result) async {

            if (result.length == 0) {
              _faceFound = false;
            } 
            else {
              _faceFound = true;
                            

                 await _camera.stopImageStream();
              XFile file = await _camera.takePicture();
               

              String imagePath = file.path;
                sendImage(imagePath);
                startStream(rotation);
              
              // _camera.dispose();
              //Navigator.of(context).pop();
              print('hhhhhhhowowowowoowowowowoowow');
            }
            _isDetecting = false;
             

          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  } */
}
