import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ordretest/config/picture_state/picture_provider.dart';
import 'package:ordretest/config/size_config.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraPage({super.key, required this.cameras});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {


  late CameraController _cameraController;

  Future initCamera(CameraDescription cameraDescription) async {
    // create a CameraController
      _cameraController = CameraController(
        cameraDescription, ResolutionPreset.high);
    // Next, initialize the controller. This returns a Future.
      try {
        await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
        });
      } on CameraException catch (e) {
        debugPrint("camera error $e");
      }
    }

    @override
  void initState() {
    initCamera(widget.cameras[0]);
    super.initState();
  }

  Future takePicture(BuildContext context) async {
  if (!_cameraController.value.isInitialized) {return null;}
  if (_cameraController.value.isTakingPicture) {return null;}
  try {
    await _cameraController.setFlashMode(FlashMode.off);
    XFile picture = await _cameraController.takePicture();
    Uint8List myPic  = await picture.readAsBytes();
    if (context.mounted){
       PictureProvider.of(context)!.pictureStream.addImageToStream(myPic);
    }
  } on CameraException catch (e) {
    debugPrint('Error occured while taking picture: $e');
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: _cameraController.value.isInitialized
              ? Stack(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight,
                    child: CameraPreview(_cameraController)
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: SizeConfig.screenWidth,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape:  BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                            ),
                            child: IconButton(
                              onPressed:() async{
                               await  takePicture(context).then((value) {
                                  Navigator.of(context).pop();
                               });
                               
                              },
                              iconSize: 50,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.circle, color: Colors.white),
                            ),
                          )
                        ],
                      ),

                    )),
                ]):
             const Center(child:
              CircularProgressIndicator()),
      ),
    );
  }


  @override
  void dispose() {
  _cameraController.dispose();
  super.dispose();
}
}