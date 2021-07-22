/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/


import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;

  const TextFieldContainer({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.bottomCenter,
      width: size.width,
      padding: EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}