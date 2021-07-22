/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function? onPress;
  final TextStyle? textStyle;
  final bool? autofocus;

  const RoundedButton({
    Key? key,
    required this.text,
    this.onPress,
    this.autofocus = false,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Theme.of(context).buttonColor,
          child: InkWell(
            onTap: () => onPress == null ? ((){}) : onPress!(),
            autofocus: autofocus!,
            child: Container(
              height: 50,
              padding: EdgeInsets.only(left: 25, right: 25),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).indicatorColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
