/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/RoundedButton.dart';

//const kPrimaryColor = Color(0xFF6735A5);
//const kPrimaryLightColor = Color(0xFFF1E6FF);

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Only put constants shared between files here.

// height of the 'Gallery' header
const double galleryHeaderHeight = 64;

// The font size delta for headline4 font.
const double desktopDisplay1FontDelta = 16;

// The width of the settingsDesktop.
const double desktopSettingsWidth = 520;

// Sentinel value for the system text scale factor option.
const double systemTextScaleFactorOption = -1;

// The splash page animation duration.
const splashPageAnimationDurationInMilliseconds = 300;

// The desktop top padding for a page's first header (e.g. Gallery, Settings)
const firstHeaderDesktopTopPadding = 5.0;

/*
 * Functions
 */

double maxSize(double screenWidth, double maxSize) {
  // Extra small
  // <576px	Small
  // ≥576px	Medium
  // ≥768px	Large
  // ≥992px	Extra large
  // ≥1200px

  Library.debugPrint("maxSize was run");

  if (screenWidth < maxSize) {
    return screenWidth;
  } else {
    return maxSize;
  }
}

double screenWidth(double screenWidth, [bool fullWidth = false]) {
  late double x;
  Library.debugPrint("screenWidth was run. screenWidth: " + screenWidth.toString());

  if (screenWidth < 576) {
    x = 576;
  } else if ((screenWidth >= 576) && (screenWidth < 768)) {
    x = 576;
  } else if ((screenWidth >= 768) && (screenWidth < 992)) {
    x = 768;
  } else if ((screenWidth >= 992) && (screenWidth < 1200)) {
    x = 992;
  } else if ((screenWidth >= 1200) && (screenWidth < 1440)) {
    x = 1200;
  } else if (screenWidth >= 1440) {
    x = 1440;
  } else {
    x = 576;
  }

  return fullWidth ? screenWidth : x;
}

class SizeConfig {
  Size size;

  SizeConfig(this.size);

  int get crossAxisCount => _crossAxisCount();

  int _crossAxisCount() {
    Library.debugPrint("SizeConfig was run");

    var screenWidth = size.width;
    var r;

    if (screenWidth < 576) {
      r = 1;
    } else if ((screenWidth >= 576) && (screenWidth < 768)) {
      r = 2;
    } else if ((screenWidth >= 768) && (screenWidth < 992)) {
      r = 3;
    } else if ((screenWidth >= 992) && (screenWidth < 1200)) {
      r = 4;
    } else if ((screenWidth >= 1200) && (screenWidth < 1440)) {
      r = 5;
    } else if (screenWidth >= 1440) {
      r = 6;
    } else {
      r = 1;
    }

    return r;
  }
}

/*// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}*/

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  String? text,
  bool useSafeArea = false,
}) {
  assert(text != null);

  return showDialog<T>(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Scrollbar(
                      showTrackOnHover: true,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                              maxWidth: 500,
                              maxHeight: 400,
                            ),
                            child: SelectableText(
                              text!,
                              textAlign: TextAlign.center,
                              style: Library.textStyle.copyWith(color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RoundedButton(
                          autofocus: true,
                          text: AppLocalizations.getTranslate("0006"),
                          onPress: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    useSafeArea: useSafeArea,
    barrierDismissible: true,
  ).timeout(Duration(seconds: 30), onTimeout: () {
    Navigator.of(context, rootNavigator: true).pop();
    Library.globalData["isLoginAttempt"] = false;
  }).then((x) {
    Library.globalData["isLoginAttempt"] = false;
  });
}

Future<T?> showLoadingDialog<T>({
  required BuildContext context,
  required Widget child,
  bool useSafeArea = true,
}) {
  Library.globalData["showLoadingDialog"] = true;
  Library.globalData["dialogContext"] = context;

  return showDialog(
    context: context,
    builder: (context) {
      return child;
    },
    useSafeArea: useSafeArea,
    barrierDismissible: false,
  ).then((x) {
    Library.globalData["showLoadingDialog"] = false;
  });
}

Future<bool> closeLoadingDialog() async {
  try {
    if (Library.globalData["showLoadingDialog"]) {
      Navigator.of(Library.globalData["dialogContext"], rootNavigator: true).pop();
    }
    return true;
  } catch (e) {
    return false;
  }
}
