/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:ui';

import 'package:spine/components/ImageLoader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class GridViewContainer extends StatelessWidget {
  final String? text;
  final String image;

  const GridViewContainer({Key? key, this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            offset: Offset(0, 0),
            blurRadius: 17,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(30)),
        //color: kPrimaryLightColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              print("Click");
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                            child: ImageLoader(imageUrl: image.isEmpty
                                ? "https://i.stack.imgur.com/jq2eV.png?s=328&g=1"
                                : image, decoration: BoxDecoration(),),

                      ),
                    ),
                    Text(
                      HtmlUnescape().convert(text!),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
