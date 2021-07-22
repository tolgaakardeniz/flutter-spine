/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';

import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/themes/default.dart';
import 'package:spine/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/LoadingScreen';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "LoadingScreen";
  late int screenCount;

  Future<dynamic> checkLogin() async {
    try {
      var userInfo = await StorageManager.readData("lastUser");
      var userId = await StorageManager.readData("lastUserId");

      userInfo = getJson(userInfo);

      if (!userInfo.runtimeType.toString().contains("HashMap")) {
        userInfo = null;
        userId = null;
      }

      Library.globalData["userInfo"] = userInfo;
      Library.globalData["userId"] = userId;

      var y = Library.globalData["userInfo"];

      Provider.of<Notifier>(context, listen: false).user = User(
        id: y["id"],
        userName: y["userName"],
        password: y["password"],
        firstName: y["firstName"],
        lastName: y["lastName"],
        email: y["email"],
        active: y["active"],
        createdTime: DateTime.parse(y["createdTime"]),
        avatar: y["avatar"],
        background: y["background"],
      );

      Users.activeUser = int.parse(Library.globalData["userId"]);

      Library.globalData["Notifier"].isLoggedIn = LoginStatus.mainScreen;
      return Library.globalData["MainScreen"];
    } catch (e) {
      return Library.globalData["WelcomeScreen"];
    }
  }

  /// if you want to rebuild this widget please call this function
  void reBuild() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));

    print("reBuild: " + screenName);
  }

  /// if you want to refresh state please call this function
  void refreshState() {
    setState(() {
      Library.debugPrint(screenName + " widget setState is was now run");
    });

    print("refreshState: " + screenName);
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies : " + screenName);

    try {
      final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
      parentObject = arguments["parentObject"];
    } catch (e) {
      Library.debugPrint(e);
    }

    Library.globalData["RouteObserver"].subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPush() async {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush: " + screenName);

    var y = await checkLogin().then((x) {
      return x;
    });

    Library.openNavigator(context, y, {"parentObject": this});
  }

  @override
  void didPopNext() async {
    // Covering route was popped off the navigator.
    print("didPopNext: " + screenName);

    var y = await checkLogin().then((x) {
      return x;
    });

    Library.openNavigator(context, y, {"parentObject": this});
  }

  @override
  void dispose() {
    Library.globalData["RouteObserver"].unsubscribe(this);

    print("dispose: " + screenName);

    /**
     * Remove in map list
     */
    Library.globalData["widgetList"].remove(screenCount);
    Library.globalData["widgetNameList"][screenName].remove(screenCount);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LoadingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget == oldWidget) {
      // TODO: start a transition between the previous and new value
    }

    print("didUpdateWidget: " + screenName);
  }

  @override
  void initState() {
    super.initState();

    /**
     * Ana widget sınıfını widgets listesinin içine ekle
     * Add this widget in widgets map lists
     */
    Library.globalData["widgetListCount"]++;
    screenCount = Library.globalData["widgetListCount"];

    /**
     * Bu widget için map oluştur
     */
    Library.globalData["widgetList"][screenCount] = <dynamic, dynamic>{};

    /**
     * Ad listesine ekle
     */
    if (!Library.globalData["widgetNameList"].containsKey(screenName)) {
      Library.globalData["widgetNameList"][screenName] = [];
    }

    Library.globalData["widgetNameList"][screenName].add(screenCount);

    /**
     * Class
     */
    Library.globalData["widgetList"][screenCount]["class"] = this;

    /**
     * Aktif wiget adı
     */
    Library.globalData["widgetList"][screenCount]["name"] = screenName;

    /**
     * Bu widget için animasyon kontrolcülerinin ekleneceği bir "map" oluştur
     * Create a map to add animation controllers for this widget
     */
    Library.globalData["widgetList"][screenCount]["animations"] = <dynamic, dynamic>{};

    print("initState: " + screenName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //We need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        body: Center(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  AppLocalizations.getTranslate("0017"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
