/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/themes/default.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemChangerButton extends StatelessWidget {
  final String text;
  final Color? color;
  final FlexScheme flexScheme;

  const ThemChangerButton({Key? key, required this.text, required this.flexScheme, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Notifier>(
      builder: (context, notifier, child) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
/*            hoverColor: color ?? Theme.of(context).hoverColor,*/
            onTap: () {
              notifier.setFlexScheme(flexScheme);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 10), child: Icon(Icons.circle, color: color ?? Theme.of(context).indicatorColor,),),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}