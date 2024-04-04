import 'package:flutter/widgets.dart';

/// Split the screen up into a 100x100 grid allowing for certain widgets
/// to responsive scale. Note, this should only be used for containers,
/// shapes and graphics.

class SizeConfig {
  static MediaQueryData? _mediaQueryData;

  static double? smBreakpoint = 375;
  static double? mdBreakpoint = 550;

  static double? screenWidth;
  static double? screenHeight;

  static double? bottomPadding;
  static double? topPadding;

  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? gridCell = 8;

  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;

  static get isSmBreakpoint => screenWidth! <= smBreakpoint!;
  static get isMdBreakpoint => screenWidth! <= mdBreakpoint!;

  SizeConfig init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;

    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = screenHeight! / 100;

    bottomPadding = _mediaQueryData!.padding.bottom;
    topPadding = _mediaQueryData!.padding.top;

    _safeAreaHorizontal = _mediaQueryData!.padding.left + _mediaQueryData!.padding.right;
    _safeAreaVertical = _mediaQueryData!.padding.top + _mediaQueryData!.padding.bottom;

    safeBlockHorizontal = (screenWidth! - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight! - _safeAreaVertical!) / 100;

    return this;
  }
}
