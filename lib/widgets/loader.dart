import 'package:flutter/material.dart';

import '../../application/app_theme/color_scheme.dart';
import '../../base/base_widget.dart';

class Loader extends BaseStateLessWidget {
  final Color? color;
  Loader({super.key,this.color});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: color ?? ColorManager.primary,),
    );
  }
}
