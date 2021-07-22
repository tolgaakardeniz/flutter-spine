/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:spine/data/library.dart';

enum CustomTextDirection {
  localeBased,
  ltr,
  rtl,
}

// See http://en.wikipedia.org/wiki/Right-to-left
const List<String> rtlLanguages = <String>[
  'ar', // Arabic
  'fa', // Farsi
  'he', // Hebrew
  'ps', // Pashto
  'ur', // Urdu
];

// Fake locale to represent the system Locale option.
const systemLocaleOption = Locale('system');

/// Load all languages
class LoadLanguages {
  static bool isLoad = false;

  static Future<dynamic> loadAllLanguages(BuildContext context) async {
    if (isLoad) {
      return true;
    }

    final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final jsonPaths = manifestMap.keys
        .where((String key) => key.contains('languages/'))
        //.where((String key) => key.contains('.json'))
        .toList();

    if (jsonPaths.length > 0) {
      for (var path in jsonPaths) {
        var temp = await rootBundle.loadString(path);
        Library.debugPrint(temp + "\nLoaded to $path");
      }

      isLoad = true;
    }

/*
    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
    //.where((String key) => key.contains('.json'))
        .toList();

    if (imagePaths.length > 0) {
      for (var path in imagePaths) {
        Image.asset(path);
          Library.debugPrint(path + "\nLoaded to $path");
      }
    }
*/

    return true;
  }
}

class AppLocalizations {
  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('tr', "TR"),
    Locale('en', "US"),
  ];

  /// A list of this languages not found translate errors.
  static const Map<String, String> translateErrors = {
    "tr" : "Bir hata oluştu. Dil listesinden çeviri bulunamadı.",
    "en" : "An error occurred. Translate not found from language list.",
  };

  /// A list of this localizations delegate's supported locales.
  static const Map<String, String> settingUp = {'tr': "Sistem dili Türkçe olarak tanımlanmıştır.", 'en': "The system language is defined as English."};

  AppLocalizations();

  Locale get locale => Library.globalData["deviceLocale"];

  /*AppLocalizations(this.locale);*/

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static Map<String, dynamic> _localizedStrings = {};

  Future<bool> load() async {
    String jsonString;
    Map<String, dynamic> jsonMap;

    try {
      jsonString = await rootBundle.loadString('assets/languages/${locale.languageCode}.json');
    } catch (e) {
      jsonString = await rootBundle.loadString('assets/languages/tr.json');
    }

    if (jsonString.isEmpty) {
      jsonString = "{}";
    }

    jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((k, v) {
      return MapEntry(k, v.toString());
    });

    return true;
  }

  static String getTranslate(String translatedString) {
    try {
      return _localizedStrings[translatedString] ??= translateErrors[Library.globalData["deviceLocale"].toString()];
    } catch (e)
    {
      return translateErrors["en"] ??= "";
    }
  }

  static googleTranslate(String word) async {
    final translator = GoogleTranslator();

    var translation = await translator.translate(word, from: 'en', to: 'tr');

    return translation;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => <String>[
        'en',
        'tr',
      ].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations();
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
