import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

marqeeText(String text, TextStyle style) {
  return Marquee(
    text: text,
    style: style,
    scrollAxis: Axis.horizontal,
    crossAxisAlignment: CrossAxisAlignment.start,
    blankSpace: 50,
    velocity: 15,
    pauseAfterRound: Duration(seconds: 1),
    startPadding: 10.0,
    accelerationDuration: Duration(seconds: 1),
    accelerationCurve: Curves.linear,
    decelerationCurve: Curves.easeInOut,
    decelerationDuration: Duration(milliseconds: 300),
  );
}
