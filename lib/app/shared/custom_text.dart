import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';

///Responsive bold text
Text boldText(
  String text, {
  double size = 14,
  TextAlign align = TextAlign.start,
  Color color = Colors.black,
}) {
  return Text(
    text,
    textAlign: align,
    overflow: TextOverflow.ellipsis,
    maxLines: 3,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size.sp,
      color: color,
    ),
  );
}

///Responsive normal text
Text normalText(
  String text, {
  double size = 14.0,
  TextAlign align = TextAlign.start,
  Color color = Colors.black,
}) {
  return Text(
    text,
    textAlign: align,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: size.sp, color: color),
  );
}
