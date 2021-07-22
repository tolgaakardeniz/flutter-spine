/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class ShapedWidgetBorder extends RoundedRectangleBorder {
  final double? padding;

  ShapedWidgetBorder({
    this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero,
  }) : super(side: side, borderRadius: borderRadius);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.width - 20, rect.top)
      ..lineTo(rect.width - 30, rect.top - 10)
      ..lineTo(rect.width - 40, rect.top)
      ..addRRect(borderRadius.resolve(textDirection).toRRect(Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height)));
  }
}