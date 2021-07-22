/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

// Our design contains Neumorphism design and i made a extention for it
// We can apply it on any  widget

extension Neumorphism on Widget {
  addShadow({
    double borderRadius = 0,
    Offset offset = const Offset(0, 0),
    double blurRadius = 15,
    Color topShadowColor = Colors.black54,
    Color bottomShadowColor = Colors.black54,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: [
          BoxShadow(
            offset: offset,
            blurRadius: blurRadius,
            color: bottomShadowColor,
          ),
/*          BoxShadow(
            offset: Offset(-offset.dx, -offset.dx),
            blurRadius: blurRadius,
            color: topShadowColor,
          ),*/
        ],
      ),
      child: this,
    );
  }
}
