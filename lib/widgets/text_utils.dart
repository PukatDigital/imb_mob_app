import 'package:flutter/material.dart';


class TextUtils {
  String fontFamily = "Mulish-Regular";

  Text normal(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontFamily: fontFamily, fontWeight: FontWeight.normal),
    );
  }

  Text medium(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
     // overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize:fontSize, fontWeight: FontWeight.w500, fontFamily: fontFamily),
    );
  }

  Text semiBold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.w700, fontFamily: fontFamily),
    );
  }

  Text bold(text, color,fontSize, align, {height, maxLines}) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(color: color, height: height, fontSize: fontSize, fontWeight: FontWeight.bold, fontFamily: fontFamily),
    );
  }


}
