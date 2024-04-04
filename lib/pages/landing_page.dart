import 'package:flutter/services.dart';
import 'package:image/image.dart' as imgLib;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ordretest/config/picture_state/picture_provider.dart';
import 'package:ordretest/config/size_config.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  Future<Uint8List> getGrayscale(Uint8List imageData) async {
  imgLib.Image image = imgLib.grayscale(imgLib.decodeImage(Uint8List.view(imageData.buffer))!);
  return imgLib.encodePng(image);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:const EdgeInsets.all(10),
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: SizeConfig.screenWidth,
                height: SizeConfig.safeBlockVertical! * 10,
                child: Image.asset(
                  'assets/images/ordreGroup.jpeg',
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(5.0),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black87),
                    borderRadius:
                        BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                shadowColor: MaterialStateProperty.all<Color>(
                    Colors.black54,
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                   Colors.blue[100]!,
                ),
              ),
              onPressed: () async{

                await availableCameras().then(
                (value) {
                   Navigator.of(context).pushNamed('/camera',arguments: value);
                }
              );
               
              },
              child: Container(
                padding: const  EdgeInsets.all(20),
                child:const Column(
                  children: [
                     SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.camera,
                      size: 40,
                      color: Colors.black54,
                    ),
                     SizedBox(
                      height: 10,
                    ),
                     Text.rich(
                        textAlign:  TextAlign.center ,
                        TextSpan(
                          text: 'Take a picture',
                          style: TextStyle(
                            color:  Colors.black87,
                            fontSize:  25 ,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                  ],
                ),
              ),),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 5,
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black87,
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: StreamBuilder(
                    stream: PictureProvider.of(context)!.pictureStream.imageStream,
                    builder: (context, image) { 
                       if(!image.hasData){
                        return const Center(
                          child:  Text.rich( TextSpan(
                            text: 'No picture has been taken.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            )
                          )),
                        );
                       }
                       return  FutureBuilder(
                         future: getGrayscale(image.data!),
                         builder: (context, grayscaleImage) {
                          if(!grayscaleImage.hasData){
                            return const Center(
                              child:  Text.rich( TextSpan(
                                text: 'Transforming ...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                )
                              )),
                            );
                          }



                           return Column(mainAxisSize: MainAxisSize.min, children: [
                            const SizedBox(height: 20),
                            Image.memory(grayscaleImage.data!, fit: BoxFit.cover, width: 200),
                            const SizedBox(height: 20),
                          ]);
                         }
                       );
                    }
                  ),
              ),
              
          ],
        ),
      ),
    );
  }
}