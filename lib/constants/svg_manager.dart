import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgManager {
  SvgManager._();

  static SvgPicture getSVG(String assets, {String? semanticsLabel, double? width, double? height}) =>
      SvgPicture.asset(assets, semanticsLabel: semanticsLabel, width: width, height: height);

  static Widget getSVGWithColor(String assets, Color color, {String? semanticsLabel, double? width, double? height}) =>
      SvgPicture.asset(assets,
          semanticsLabel: semanticsLabel, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: width, height: height);
}
