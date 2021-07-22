/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

enum userStatus {
  active,
  passive,
}

class Users {
  static late int activeUser;

  Users({
    required int id,
    required String userName,
    required String password,
    required String firstName,
    required String lastName,
    required String email,
    String? avatar,
    String? background,
    required int active,
    int? messages,
    int? votes,
    int? likes,
    int? followers,
    int? follow,
    int? profileCounter,
    int? loginCounter,
    int? logoutCounter,
    int? status,
    int? emailValid,
    required DateTime createdTime,
    DateTime? sessionTime,
    DateTime? exitTime,
    DateTime? lastActivityTime,
  }) {
    activeUser = id;

    userList[id] = {
      "id": id,
      "userName": userName,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "avatar": avatar ?? null,
      "background": background ?? null,
      "active": active,
      "messages": messages ?? null,
      "votes": votes ?? null,
      "likes": likes ?? null,
      "followers": followers ?? null,
      "follow": follow ?? null,
      "profileCounter": profileCounter ?? null,
      "loginCounter": loginCounter ?? null,
      "logoutCounter": logoutCounter ?? null,
      "status": status ?? null,
      "emailValid": emailValid ?? null,
      "createdTime": createdTime,
      "sessionTime": sessionTime ?? null,
      "exitTime": exitTime ?? null,
      "lastActivityTime": lastActivityTime ?? null,
    };
  }

  static Map<int, dynamic> userList = Map();

  get isSetUser {
/*    assert(() {
      if (!userList.containsKey(activeUser)) {
        throw FlutterError(activeUser.toString() + " " + userList.containsKey(activeUser).toString());
      }
      return true;
    }());*/

    return userList.containsKey(activeUser);
  }
}

class User extends Users {
  final int id;
  final String userName;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;
  final String? background;
  final int active;
  final int? messages;
  final int? votes;
  final int? likes;
  final int? followers;
  final int? follow;
  final int? profileCounter;
  final int? loginCounter;
  final int? logoutCounter;
  final int? status;
  final int? emailValid;
  final DateTime createdTime;
  final DateTime? sessionTime;
  final DateTime? exitTime;
  final DateTime? lastActivityTime;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.active,
    required this.createdTime,
    this.background,
    this.messages,
    this.avatar,
    this.votes,
    this.likes,
    this.followers,
    this.follow,
    this.profileCounter,
    this.loginCounter,
    this.logoutCounter,
    this.status,
    this.emailValid,
    this.sessionTime,
    this.exitTime,
    this.lastActivityTime,
  })  : assert(() {
          if (!email.isValidEmail()) {
            throw FlutterError(AppLocalizations.getTranslate("0014"));
          }
          return true;
        }()),
        super(
            id: id,
            userName: userName,
            password: password,
            firstName: firstName,
            lastName: lastName,
            email: email,
            active: active,
            avatar: avatar,
            background: background,
            messages: messages,
            votes: votes,
            likes: likes,
            followers: followers,
            follow: follow,
            profileCounter: profileCounter,
            loginCounter: loginCounter,
            logoutCounter: logoutCounter,
            status: status,
            emailValid: emailValid,
            createdTime: createdTime,
            sessionTime: sessionTime,
            exitTime: exitTime,
            lastActivityTime: lastActivityTime);

  User copyWith({
    int? id,
    String? userName,
    String? password,
    String? firstName,
    String? lastName,
    String? email,
    String? avatar,
    String? background,
    int? active,
    int? messages,
    int? votes,
    int? likes,
    int? followers,
    int? follow,
    int? profileCounter,
    int? loginCounter,
    int? logoutCounter,
    int? status,
    int? emailValid,
    DateTime? createdTime,
    DateTime? sessionTime,
    DateTime? exitTime,
    DateTime? lastActivityTime,
  }) {
    return User(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      active: active ?? this.active,
      avatar: avatar ?? this.avatar,
      background: background ?? this.background,
      messages: messages ?? this.messages,
      votes: votes ?? this.votes,
      likes: likes ?? this.likes,
      followers: followers ?? this.followers,
      follow: follow ?? this.follow,
      profileCounter: profileCounter ?? this.profileCounter,
      loginCounter: loginCounter ?? this.loginCounter,
      logoutCounter: logoutCounter ?? this.logoutCounter,
      status: status ?? this.status,
      emailValid: emailValid ?? this.emailValid,
      createdTime: createdTime ?? this.createdTime,
      sessionTime: sessionTime ?? this.sessionTime,
      exitTime: exitTime ?? this.exitTime,
      lastActivityTime: lastActivityTime ?? this.lastActivityTime,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is User &&
      id == other.id &&
      userName == other.userName &&
      password == other.password &&
      firstName == other.firstName &&
      lastName == other.lastName &&
      email == other.email &&
      active == other.active &&
      avatar == other.avatar &&
      background == other.background &&
      messages == other.messages &&
      votes == other.votes &&
      likes == other.likes &&
      followers == other.followers &&
      follow == other.follow &&
      profileCounter == other.profileCounter &&
      loginCounter == other.loginCounter &&
      logoutCounter == other.logoutCounter &&
      status == other.status &&
      emailValid == other.emailValid &&
      createdTime == other.createdTime &&
      sessionTime == other.sessionTime &&
      exitTime == other.exitTime &&
      lastActivityTime == other.lastActivityTime;

  @override
  int get hashCode => hashValues(
        id,
        userName,
        password,
        firstName,
        lastName,
        email,
        active,
        messages,
        votes,
        likes,
        followers,
        follow,
        profileCounter,
        loginCounter,
        logoutCounter,
        status,
        emailValid,
        createdTime,
        sessionTime,
        exitTime,
      );

  static Future<dynamic> getLogin(String userName, String password) async {
    if (userName.isEmpty || password.isEmpty) {
      return false;
    } else {
      var pass = md5.convert(utf8.encode(password)).toString();
      pass = md5.convert(utf8.encode(pass)).toString();

      var x = await httpPost("getLogin/", {"userName": userName, "password": pass, "remember": "false"}).then((x) {
        if (x.containsKey("return")) {
          var y = getJson(utf8.decode(x["bodyBytes"]));

          if (y.runtimeType.toString() != "String") {
            x.addEntries(y.entries);

            if (x["return"]) {
              if (x.containsKey("status")) {
                if (x["status"] && x.containsKey("userInfo")) {
                  try {
                    x["userInfo"] = getJson(x["userInfo"]);
                  } catch (e) {
                    x["userInfo"] = null;
                  }

                  if (x["userInfo"].length > 0) {
                  } else {
                    y = utf8.decode(x["bodyBytes"]);

                    x["return"] = false;
                    x["error"] = y;
                  }
                } else {
                  if (x.containsKey("errorCount")) {
                    if (x["errorCount"] > 0) {
                      y = x["errors"].join("\n");
                    }
                  } else {
                    y = utf8.decode(x["bodyBytes"]);
                  }

                  x["return"] = false;
                  x["error"] = y;
                }
              } else {
                if (x.containsKey("errorCount")) {
                  if (x["errorCount"] > 0) {
                    y = x["errors"].join("\n");
                  }

                  x["error"] = y;
                } else {
                  x["error"] = AppLocalizations.getTranslate("0052") + "\n\n" + utf8.decode(x["bodyBytes"]);
                }

                x["return"] = false;
              }
            } else {
              x["error"] = utf8.decode(x["bodyBytes"]);
            }
          } else {
            x["return"] = false;
            x["error"] = AppLocalizations.getTranslate("0052") + "\n\n" + y + " " + x["error"];
          }
        } else {
          x = <String, dynamic>{};
          x["return"] = false;
          x["error"] = AppLocalizations.getTranslate("0010") + " " + AppLocalizations.getTranslate("0051");
        }

        return x;
      }).catchError((e, s) {
        throw (e);
      });

      return x;
    }
  }
}

const Map<String, String> postDefaultHeaders = {};

Future<Map<String, dynamic>> httpPost(String httpAddress, Map<String, String> postData, [Map<String, String> _postHeaders = postDefaultHeaders]) async {
  late final http.Response r;
  late Map<String, dynamic> x = Map();
  late Map<String, String> postHeaders = Map();

  postHeaders.addEntries(_postHeaders.entries);
  postHeaders.addEntries({MapEntry("User-Agent", "FlutterApp")});

  if (NetworkService.cookies.length > 0) {
    String a = "";
    NetworkService.cookies.forEach((k, v) {
      a += k + "=" + v + ";";
    });
    postHeaders.addEntries({MapEntry("Cookie", a)});
  }

  /*Cookie: PhpProje=9fc0de851e3130a7cf4023dffddc615f; PhpProjeKey=cf11c9b86d03abdf8150517f6a1af9fe; SonGirilenSayfa=%2F; BeniHatirla=1de503340721a453677ed12cc56fe04c*/

  try {
    r = await http.post(Uri.parse(httpApiAddress + httpAddress), headers: postHeaders, body: postData, encoding: Encoding.getByName("utf-8")).timeout(Duration(seconds: 25), onTimeout: () {
      throw (AppLocalizations.getTranslate("0009"));
    });

    /**
     * set getting request headers
     */
    x["headers"] = getJson(r.headers);
    x["statusCode"] = r.statusCode;
    x["bodyBytes"] = r.bodyBytes;
    NetworkService._updateCookie(r);
    x["cookies"] = NetworkService.cookies;

    switch (r.statusCode) {
      case 200:
        x["return"] = true;
        break;
      default:
        x["return"] = false;
        x["error"] = r.body.isEmpty ? x["headers"].toString() : r.body;
        break;
    }
  } on TimeoutException catch (e) {
    x["return"] = false;
    x["error"] = e.toString();
    //throw TimeoutException(e.toString());
  } on Error catch (e) {
    x["return"] = false;
    x["error"] = e.toString();
    //throw Exception(e.toString());
  }

  return x;
}

dynamic getJson(dynamic x) {
  try {
    return json.decode(x);
  } catch (e) {
    return x;
  }
}

class NetworkService {
  static Map<String, String> headers = {"content-type": "text/json"};
  static Map<String, String> cookies = {};

  static void _updateCookie(http.Response response) {
    if (response.headers.containsKey("set-cookie")) {
      String? allSetCookie = response.headers["set-cookie"];

      if (allSetCookie != null) {
        var setCookies = allSetCookie.split(',');

        for (var setCookie in setCookies) {
          var cookies = setCookie.split(';');

          for (var cookie in cookies) {
            _setCookie(cookie);
          }
        }

        headers['cookie'] = _generateCookieHeader();
      }
    }
  }

  static void _setCookie(String rawCookie) {
    if (rawCookie.length > 0) {
      var keyValue = rawCookie.split('=');
      if (keyValue.length == 2) {
        var k = keyValue[0].trim();
        var v = keyValue[1];

        if (_cookiesKeysToIgnore.contains(k.toLowerCase())) return;

        cookies[k] = v;
      }
    }
  }

  static final Set _cookiesKeysToIgnore = {'samesite', 'path', 'domain', 'max-age', 'expires', 'secure', 'httponly'};

  static String _generateCookieHeader() {
    String cookie = "";

    for (var key in cookies.keys) {
      if (cookie.length > 0) cookie += ";";
      cookie += key + "=" + cookies[key].toString();
    }

    return cookie;
  }
}
