/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/themes/default.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$').hasMatch(this);
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(r'^.{0,32}$').hasMatch(this);
  }
}

extension UserNameValidator on String {
  bool isValidUserName() {
    return RegExp(r'^(?![0-9]+)[A-Za-z0-9-_]{3,24}$').hasMatch(this);
  }
}

extension NameAndSurnameValidator on String {
  bool isValidNameAndSurname() {
    return RegExp(r'^[^\d\s]{3,}(?:( {1}[^\d\s\W]{3,})+)$').hasMatch(this);
  }
}

enum ScreenStatus { active, passive }

get httpAddress => "http://10.7.7.100";

get httpsAddress => "https://10.7.7.100";

get httpApiAddress => "http://10.7.7.100/api/";

get httpsApiAddress => "https://10.7.7.100/api/";

class Library {
  /// Sonradan kullanmak uzara istenen bütün fonksiyonları classları vb eklemek için kullan
  static Map<String, dynamic> globalData = {};
  static FlexScheme flexScheme = FlexScheme.values[3];
  static bool darkTheme = true;
  static String userAvatar = "assets/images/avatar.png";
  static String avatar = "https://pbs.twimg.com/profile_images/1224107572258639878/ziu88onP_400x400.jpg";

  /// Widget'leri bu fonksiyon ile açacağız
  static openNavigator(BuildContext context, String routeName, Object arguments) async {
    if (!globalData["contextList"].containsKey(routeName)) {
      globalData["contextList"][routeName] = context;

      globalData["widgetCloseResult"] = await Navigator.pushNamed(context, routeName, arguments: arguments).whenComplete(() {
        globalData["contextList"].remove(routeName);
      });
    }
  }

  /// Close all context for logout
  static void closeAllContext() {
    try {
      globalData["contextList"].forEach((k, v) {
        print(k);
        if ("WelcomeScreen" != k) {
          Navigator.of(v, rootNavigator: true).pop(true);
        }
      });

/*      print(Library.globalData.toString());*/

/*      if (Library.globalData["contextList"].containsKey("WelcomeScreen")) {
        Library.globalData["WelcomeScreen"]["class"].build();
      }*/

      Library.globalData["Notifier"].isLoggedIn = LoginStatus.welcomeScreen;
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  static ThemeData lightThemeData() {
    return FlexColorScheme.light(
      scheme: flexScheme,
      fontFamily: fontFamily,
/*      colors: FlexColor.schemes[flexScheme]!.light,*/
      platform: TargetPlatform.android,
    ).toTheme;
  }

  static ThemeData darkThemeData() {
    return FlexColorScheme.dark(
      scheme: flexScheme,
      fontFamily: fontFamily,
/*      colors: FlexColor.schemes[flexScheme]!.dark,*/
      platform: TargetPlatform.android,
    ).toTheme;
  }

  static final String fontFamily = "Open Sans";

  static const _light = FontWeight.w200;
  static const _regular = FontWeight.w400;

/*  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static const _extraBold = FontWeight.w900;*/

  static const double fontSize = 14;
  static TextStyle textStyle = TextStyle(
    fontWeight: _regular,
    fontSize: fontSize,
    fontFamily: Library.fontFamily,
    decoration: TextDecoration.none,
  );

  static final TextTheme textTheme = TextTheme(
    headline4: textStyle,
    caption: textStyle,
    headline5: textStyle,
    subtitle1: textStyle,
    overline: textStyle,
    bodyText1: textStyle,
    subtitle2: textStyle,
    bodyText2: textStyle,
    headline6: textStyle,
    button: TextStyle(fontWeight: _light, fontSize: fontSize),
    headline1: textStyle,
    headline2: textStyle,
    headline3: textStyle,
  );

  static void debugPrint(dynamic x) {
    if (Library.globalData["debugMode"]) {
      print(x.toString());
    }
  }
}
