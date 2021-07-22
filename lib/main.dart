/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/data/library.dart';
import 'package:spine/screens/loading.dart';
import 'package:spine/screens/main.dart';
import 'package:spine/screens/register.dart';
import 'package:spine/screens/remember.dart';
import 'package:spine/screens/settings.dart';
import 'package:spine/screens/start.dart';
import 'package:spine/screens/welcome.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:spine/themes/default.dart';
import 'package:spine/localizations.dart';


void main([List<String>? args]) {
  /**
   * Programın içerisinde hata ayıklama için tanımlanmış ilage bilgi gösterimini görmek için bunu değiştir
   * If you want to see debugPrint change true this variable
   */
  Library.globalData["debugMode"] = false;

  /**
   * Uygulamanın her yerinde kullanmak için boş bir widgets listesi oluştur
   * Create new widgets map list
   */
  Library.globalData["widgetList"] = <dynamic, dynamic>{};
  Library.globalData["widgetNameList"] = <dynamic, dynamic>{};
  Library.globalData["widgetListCount"] = 0;

  /**
   * Animasyonları geri oynatabilmek için kullanılacak
   * Global animation controller list
   */
  Library.globalData["animationController"] = <dynamic, dynamic>{};
  Library.globalData["animationCount"] = 0;

  /**
   * All context list
   */
  Library.globalData["contextList"] = Map<dynamic, dynamic>();



  Library.globalData["LoadingScreen"] = LoadingScreen.routeName;
  Library.globalData["WelcomeScreen"] = WelcomeScreen.routeName;
  Library.globalData["RememberScreen"] = RememberScreen.routeName;
  Library.globalData["RegisterScreen"] = RegisterScreen.routeName;
  Library.globalData["StartScreen"] = StartScreen.routeName;
  Library.globalData["MainScreen"] = MainScreen.routeName;
  Library.globalData["SettingsScreen"] = SettingsScreen.routeName;


  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Notifier()),
        Provider(create: (_) => Deneme()),
        Provider<RouteObserver>(create: (_) => RouteObserver()),
      ],
      child: Root(),
    ),
  );
}

class Deneme {
  dynamic userInfo;
  dynamic userId;
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * Tema daha önce seçilmiş ise tema bilgilerini getir
     * Fetch theme information if theme before is already set
     */
    StorageManager.readData('flexScheme').then((flexScheme) {
      /**
       * Gelen bilgi boşsa varsayılan temayı tanımla. Boş değil ise daha önce tanımlanmış olanı tanımla.
       * If the incoming information is blank, define the default theme. If not empty, define previously defined.
       */
      flexScheme = (flexScheme == "null" || flexScheme == null) ? "3" : flexScheme;

      /**
       * Tanımlanan tema bilgisini programa uygula
       * Apply the defined theme information to the program
       */
      Library.flexScheme = FlexScheme.values[int.parse(flexScheme)];

      /**
       * Ayarların uygulanması için program durumunu güncelle
       * Update program status to update application settings
       */
    });


    /// Android vb ekranın yataylık durumu
    //Library.debugPrint(MediaQuery.of(context).orientation.toString());

    /**
     * Tüm dil dosyalarını yükle
     * Load all languages
     */
/*    LoadLanguages.loadAllLanguages(context);*/

    /**
     * If you want to see platform theme mode use this variable
     * MediaQuery.of(context).platformBrightness == Brightness.dark
     */
    Library.globalData["systemThemeMode"] = (SchedulerBinding.instance!.window.platformBrightness == Brightness.dark) ? ThemeMode.dark : ThemeMode.light;

    /**
     * Evrensel veri listesine Notifier nesnesini ekledik
     */
    Library.globalData["Notifier"] = Provider.of<Notifier>(context);

    /**
     * Evrensel veri listesine RouteObserver nesnesini ekledik
     */
    Library.globalData["RouteObserver"] = Provider.of<RouteObserver>(context);

    /**
     * Global context
     */
    Library.globalData["rootContext"] = context;


    return MaterialApp(
      restorationScopeId: 'Root',
      onGenerateTitle: (context) => AppLocalizations.getTranslate("0000"),
      theme: Provider.of<Notifier>(context).getLightThemeData(),
      darkTheme: Provider.of<Notifier>(context).getDarkThemeData(),
      themeMode: Provider.of<Notifier>(context).themeMode(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        List<String> list = AppLocalizations.supportedLocales.map((e) => e.languageCode).toList();

        String languageCode;

        if ((locale!.languageCode.isEmpty)) {
          languageCode = "tr";
        } else {
          languageCode = locale.languageCode;
        }

        if (list.contains(languageCode) == true) {
          Library.globalData["deviceLocale"] = Locale.fromSubtags(languageCode: languageCode);
          Library.debugPrint(AppLocalizations.settingUp[languageCode]);
        } else {
          if (list.contains("tr") == true) {
            Library.globalData["deviceLocale"] = Locale.fromSubtags(languageCode: "tr");
            Library.debugPrint(AppLocalizations.settingUp["tr"]);
          } else if (list.contains("en") == true) {
            Library.globalData["deviceLocale"] = Locale.fromSubtags(languageCode: "en");
            Library.debugPrint(AppLocalizations.settingUp["en"]);
          }
        }

        return Library.globalData["deviceLocale"];
      },
      navigatorObservers: [Provider.of<RouteObserver>(context)],
      routes: {
        "/": (context) => LoadingScreen(),
        "/WelcomeScreen": (context) => WelcomeScreen(),
        "/StartScreen": (context) => StartScreen(),
        "/RememberScreen": (context) => RememberScreen(),
        "/RegisterScreen": (context) => RegisterScreen(),
        "/MainScreen": (context) => MainScreen(),
        "/SettingsScreen": (context) => SettingsScreen(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Container(
              child: Text(settings.name.toString()),
            ),
          ),
        ),
      ),
/*      home: Consumer<Notifier>(
        builder: (context, notifier, child) {
          switch (notifier.isLoggedIn) {
            case LoginStatus.accessControl:
              return Loading();
            case LoginStatus.mainScreen:
              return MainScreen();
            default:
              return WelcomeScreen();
          }
        },
      ),*/
    );
  }
}

