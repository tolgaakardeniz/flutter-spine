/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/data/library.dart';
import 'package:spine/users.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus
{
  mainScreen,
  welcomeScreen,
  accessControl,
}


class Notifier with ChangeNotifier {
  LoginStatus _isLoggedIn = LoginStatus.accessControl;
  LoginStatus get isLoggedIn => _isLoggedIn;
  set isLoggedIn(LoginStatus? x) {
    if(x == null) {
      throw new ArgumentError();
    }
    _isLoggedIn = x;
    notifyListeners();
  }

  late User _user;
  User get user => _user;
  set user(User x) {
    assert(x.runtimeType == User);
    _user = x;
    notifyListeners();
  }

  late String _userName;

  String get userName => _userName;

  set userName(String x) {
    assert(x.isEmpty == false);
    _userName = x;
    notifyListeners();
  }

  late String _password;

  String get password => _password;

  set password(String x) {
    assert(x.isEmpty == false);
    _password = x;
    notifyListeners();
  }

  ThemeData getDarkThemeData() => Library.darkThemeData();

  ThemeData getLightThemeData() => Library.lightThemeData();

  ThemeMode? _themeMode;

  //ThemeMode? themeMode() => Library.globalData["systemThemeMode"] == _themeMode ? _themeMode : Library.globalData["systemThemeMode"];
  ThemeMode? themeMode() => _themeMode;

  Notifier() {
    StorageManager.readData('themeMode').then((x) {
      switch (x) {
        case 'light':
          _themeMode = ThemeMode.light;
          Library.darkTheme = false;
          break;
        case 'dark':
          _themeMode = ThemeMode.dark;
          Library.darkTheme = true;
          break;
        default:
          _themeMode = ((Library.globalData["systemThemeMode"] == ThemeMode.dark) ? ThemeMode.dark : ThemeMode.light);
          Library.darkTheme = ((_themeMode == ThemeMode.dark) ? true : false);
          break;
      }

      Library.debugPrint("themeMode now is set to " + (_themeMode == ThemeMode.dark ? "dark" : "light"));

      notifyListeners();
    }).onError((error, stackTrace) {
      _themeMode = ThemeMode.light;
      Library.darkTheme = false;
      Library.debugPrint("themeMode now is set to " + (_themeMode == ThemeMode.dark ? "dark" : "light"));

      notifyListeners();
    });
  }

  void setDark() async {
    _themeMode = ThemeMode.dark;
    Library.darkTheme = true;
    StorageManager.saveData('themeMode', 'dark');
    Library.debugPrint('themeMode now is set to dark');

    notifyListeners();
  }

  void setLight() async {
    _themeMode = ThemeMode.light;
    Library.darkTheme = false;
    StorageManager.saveData('themeMode', 'light');
    Library.debugPrint('themeMode now is set to light');

    notifyListeners();
  }

  void setFlexScheme(FlexScheme flexScheme) async {
    Library.flexScheme = flexScheme;
    StorageManager.saveData('flexScheme', flexScheme.index);
    Library.debugPrint('flexScheme now is set to ' + flexScheme.toString());

    notifyListeners();
  }

  /// You can use this function to set user interface language.
  void setLanguage(String languageCode, String countryCode) {
    Library.globalData["deviceLocale"] = Locale.fromSubtags(languageCode: languageCode, countryCode: countryCode);
    notifyListeners();
  }

  void callNotifyListeners() {
    notifyListeners();
  }
}

///
/// You can process of read and write to data storage of user system on use this function.
///
class StorageManager {
  static void saveData(String k, dynamic v) async {
    final r = await SharedPreferences.getInstance();
    if (v is int) {
      r.setInt(k, v);
    } else if (v is String) {
      r.setString(k, v);
    } else if (v is bool) {
      r.setBool(k, v);
    } else {
      //throw("StorageManager unknown type");
      Future.error("Incoming data is unknown type for saveData function in StorageManager class.");
      //Future.error("Incoming data is unknown type for saveData function in StorageManager class.", StackTrace.fromString("This is its trace"));
    }
  }

  static Future<dynamic> readData(String k) async {
    try {
      final r = await SharedPreferences.getInstance();

      if (r.containsKey(k)) {
        return r.get(k).toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteData(String k) async {
    final r = await SharedPreferences.getInstance();

    if (r.containsKey(k)) {
      return r.remove(k);
    } else {
      return false;
    }
  }
}








