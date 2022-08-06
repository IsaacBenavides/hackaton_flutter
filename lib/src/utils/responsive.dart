import 'dart:math';
import 'package:flutter/material.dart';

class Responsive {
  double? _width, _heigth, _diagonal;

  double? get width => _width;
  double? get height => _heigth;
  double? get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _heigth = size.height;
    _diagonal = sqrt(pow(_width!, 2) + pow(_heigth!, 2));
  }

  double wp(num percent) => _width! * percent / 100;
  double hp(num percent) => _heigth! * percent / 100;
  double dp(num percent) => _diagonal! * percent / 100;
}
