import 'package:flutter/material.dart';
import 'package:ordretest/config/size_config.dart';

class CameraOverlayCircle extends CustomPainter {

  CameraOverlayCircle();

  @override
  void paint(Canvas canvas, Size size) {
    final radius = SizeConfig.screenWidth! * 0.35;
    const strokeWidth = 2.0;
    final circlePath = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(SizeConfig.screenWidth! / 2, SizeConfig.screenHeight! / 2.5),
        radius: radius,
      ));

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, SizeConfig.screenWidth!, SizeConfig.screenHeight!));
    final overlayPath =
        Path.combine(PathOperation.difference, outerPath, circlePath);

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(overlayPath, paint);
    canvas.drawCircle(
      Offset(SizeConfig.screenWidth! / 2, SizeConfig.screenHeight! / 2.5),
      radius,
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CameraOverlaySquare extends CustomPainter {

  CameraOverlaySquare();

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 2.0;
    Offset center = Offset(SizeConfig.screenWidth! /2 , SizeConfig.screenHeight! /2.5 );
    final circlePath = Path()
      ..addRect( Rect.fromCenter(center: center, width: 200, height: 200));

    final outerPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, SizeConfig.screenWidth!, SizeConfig.screenHeight!));
    final overlayPath =
        Path.combine(PathOperation.difference, outerPath, circlePath);

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
     
   
    canvas.drawPath(overlayPath, paint);
    canvas.drawRect(
     Rect.fromCenter(center: center, width: 200, height: 200),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


