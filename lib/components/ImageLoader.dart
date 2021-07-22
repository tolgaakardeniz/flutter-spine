/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';
import 'dart:convert';
import 'package:clay_containers/clay_containers.dart';
import 'package:crypto/crypto.dart';

import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

enum imageLoadStatus { none, ready, error, done }

class ImageLoader extends StatefulWidget {
  final BoxDecoration? decoration;
  final String imageUrl;

  const ImageLoader({Key? key, this.decoration, required this.imageUrl})
      : super(key: key);

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  late String url;

  get _decoration => widget.decoration==null ? BoxDecoration() : widget.decoration;

  Future<ImageProvider<Object>> getImage() async {
    late final http.Response response;

    try {
      response = await http.get(
        Uri.parse(widget.imageUrl),
      );

      if (response.statusCode == 200) {
        return MemoryImage(response.bodyBytes);
      } else {
        return ExactAssetImage(Library.userAvatar);
      }
    } catch (e) {
      return ExactAssetImage(Library.userAvatar);
    }
  }

  Widget imageLoadWidget() {
    if (Library.globalData[url]["success"] == null) {
      Library.globalData[url]["success"] = FutureBuilder(
        future: http.get(Uri.parse(widget.imageUrl)).timeout(
          Duration(seconds: 30),
          onTimeout: () {
            throw TimeoutException(AppLocalizations.getTranslate("0009"));
          },
        ),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          Widget children;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              Library.globalData[url]["status"] = imageLoadStatus.none;
              children = Center(
                child: ClayContainer(
                  borderRadius: 30,
                  color: Theme.of(context).buttonColor,
                  depth: 20,
                  spread: 0,
                  curveType: CurveType.convex,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        highlightColor: Theme.of(context).highlightColor,
                        hoverColor: Theme.of(context).hoverColor,
                        focusColor: Theme.of(context).focusColor,
                        onTap: () {
                          refreshState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.refresh,
                            color: Theme.of(context).indicatorColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );

              break;
            case ConnectionState.active:
            case ConnectionState.waiting:
              Library.globalData[url]["status"] = imageLoadStatus.ready;
              children = Center(
                child: Container(
                  child: Image(image: ExactAssetImage("assets/images/loadin.gif"),fit: BoxFit.cover, height: 64,),
                  //CircularProgressIndicator()
                ),
              );

              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                Library.globalData[url]["status"] = imageLoadStatus.error;
                Library.globalData[url]["MemoryImage"] = null;

                children = Center(
                  child: Tooltip(
                    message: AppLocalizations.getTranslate("0008") +
                        ': ${snapshot.error}',
                    child: ClayContainer(
                      borderRadius: 30,
                      color: Theme.of(context).buttonColor,
                      depth: 20,
                      spread: 0,
                      curveType: CurveType.convex,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: Theme.of(context).highlightColor,
                            hoverColor: Theme.of(context).hoverColor,
                            focusColor: Theme.of(context).focusColor,
                            onTap: () {
                              refreshState();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.refresh,
                                color: Theme.of(context).indicatorColor,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                Library.globalData[url]["status"] = imageLoadStatus.done;
                Library.globalData[url]["MemoryImage"] =
                    MemoryImage(snapshot.data!.bodyBytes);

                children = Container(
                  decoration: _decoration.copyWith(
                    image: DecorationImage(
                      image: MemoryImage(snapshot.data!.bodyBytes),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              break;
          }

          return children;
        },
      );
    }

    return Library.globalData[url]["success"];
  }


  void refreshState() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    url = md5.convert(utf8.encode(widget.imageUrl)).toString().toLowerCase();

    if (Library.globalData[url] == null) {
      Library.globalData[url] = <String, dynamic>{};
    }

    if (Library.globalData[url]["status"] == imageLoadStatus.error || Library.globalData[url]["status"] == imageLoadStatus.none)
    {
      Library.globalData[url]["status"] = null;
      Library.globalData[url]["success"] = null;
    }

    if (Library.globalData[url]["success"] == null ||
        Library.globalData[url]["status"] != imageLoadStatus.done) {
      return imageLoadWidget();
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: _decoration.copyWith(
                  image: DecorationImage(
                    image: Library.globalData[url]["MemoryImage"],
                    //NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
