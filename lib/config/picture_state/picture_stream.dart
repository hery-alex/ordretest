import 'dart:typed_data';
import 'package:rxdart/subjects.dart';

class PictureStream {

  BehaviorSubject<Uint8List> pictureStream = BehaviorSubject<Uint8List>();

  Stream<Uint8List> get imageStream => pictureStream.stream;
  Function(Uint8List) get addImageToStream => pictureStream.sink.add;


}