import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/feature/home/screen/preview_screen.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class TakeFotoPenilaianPage extends StatefulWidget {
  const TakeFotoPenilaianPage({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<TakeFotoPenilaianPage> {
  CameraController? cameraController;
  List? cameras;
  int? selectedCameraIndex;

  @override
  void initState() {
    super.initState();

    availableCameras().then((value) {
      cameras = value;
      if (cameras!.isNotEmpty) {
        selectedCameraIndex = 0;
        initCamera(cameras![selectedCameraIndex!]).then((_) {});
      } else {
        debugPrint("Tidak ada kamera");
      }
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController!.dispose();
    }

    cameraController = CameraController(cameraDescription, ResolutionPreset.high);
    cameraController!.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController!.value.hasError) {
      debugPrint("Kamera Error");
    }

    try {
      await cameraController!.initialize();
    } catch (e) {
      debugPrint("kamera error $e");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: Text(
          'Tambah Bukti Foto',
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 30,
            color: Color(0xffFF6666),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cameraPreview(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 160,
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // backButton(),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(8)),
            ),
            const Spacer(),
            cameraControl(context),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5,
                    color: const Color(0xffFF6666),
                  )),
              child: const Center(
                child: Icon(
                  Icons.video_camera_front_rounded,
                  color: Color(0xffFF6666),
                ),
              ),
            ),

            // cameraToogle(),
          ],
        ),
      ),
    );
  }

  Widget backButton() {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {},
      child: const Icon(Icons.chevron_left),
      backgroundColor: Colors.black,
    );
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Text("Loading ..");
    }
    /*return MaterialApp(
      home: CameraPreview(cameraController!),
    );*/
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * cameraController!.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;
    final double mirror = selectedCameraIndex == 1 ? math.pi : 0;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(mirror),
      child: Transform.scale(
        scale: scale,
        child: Center(
          child: CameraPreview(cameraController!),
        ),
      ),
    );
  }

  Widget cameraToogle() {
    if (cameras == null || cameras!.isEmpty) {
      return const Spacer();
    }

    CameraDescription selectedCamera = cameras![selectedCameraIndex!];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
        child: Align(
      alignment: Alignment.center,
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          onSwitchCamera();
        },
        child: Icon(getCameraLensIcon(lensDirection), color: Colors.white, size: 24),
        backgroundColor: Colors.blue,
      ),
    ));
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            onCapture(context);
          },
          child: Container(
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 10,
                color: const Color(0XFFFF6666),
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  getCameraLensIcon(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex = selectedCameraIndex! < cameras!.length - 1 ? selectedCameraIndex! + 1 : 0;
    CameraDescription selectedCamera = cameras![selectedCameraIndex!];
    initCamera(selectedCamera);
  }

  onCapture(context) async {
    try {
      await cameraController!.takePicture().then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PreviewScreen(
                      imgFile: File(value.path),
                    )));
      });
    } catch (e) {
      debugPrint('error $e');
    }
  }
}
