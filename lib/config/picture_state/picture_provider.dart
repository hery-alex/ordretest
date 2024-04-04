import 'package:flutter/material.dart';
import 'package:ordretest/config/picture_state/picture_stream.dart';

class PictureProvider  extends InheritedWidget{


final PictureStream pictureStream;

PictureProvider({super.key,Widget? child})
: pictureStream =  PictureStream(),
  super(child: child!);

  @override
  bool updateShouldNotify(PictureProvider oldWidget){
    return true;
  }

   static PictureProvider? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<PictureProvider>();
  }


}