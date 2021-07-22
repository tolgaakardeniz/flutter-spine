/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:spine/animations/FadeInDown.dart';
import 'package:spine/animations/FadeInUp.dart';
import 'package:spine/animations/RightFadeInRotateY.dart';
import 'package:spine/clippers/background.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/components/RoundedButton.dart';
import 'package:spine/constants.dart';
import 'package:spine/themes/default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/WelcomeScreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "WelcomeScreen";
  late int screenCount;

  /// if you want to rebuild this widget please call this function
  void reBuild() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));

    print("reBuild: " + screenName);
  }

  /// if you want to refresh state please call this function
  void refreshState() {
    setState(() {
      Library.debugPrint("BodyApp widget setState is was now run");
    });

    print("refreshState: " + screenName);
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies : " + screenName);

    try{
      final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
      parentObject = arguments["parentObject"];
    } catch (e)
    {
      Library.debugPrint(e);
    }

    Library.globalData["RouteObserver"].subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush: " + screenName);

  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPopNext: " + screenName);


    /**
     * Refresh status when it comes back
     */
    refreshState();
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
  void didUpdateWidget(covariant WelcomeScreen oldWidget) {
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
     * Login form in remember field
     */
    Library.globalData["remember"] = true;

    StorageManager.readData("remember").then((v) {
      if (v == "true") {
        v = true;
      } else {
        v = false;
      }

      Library.globalData["remember"] = v;
    });

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
    /**
     * Screen size information
     */
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        backPage();

        //We need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        /**
         * true olduğunda TextField tıklandığında klavye çıkıyor ve ekranı yukarı kaydırmıyor
         */
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: FadeInDown(
                parentObject: this,
                startDuration: Duration(milliseconds: 500),
                size: 30,
                child: Container(
                  width: size.width,
                  child: ClipPath(
                    clipper: BackgroundClipper(),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).primaryColorDark,
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColorLight,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (SizeConfig(size).crossAxisCount > 4)
              Positioned(
                bottom: 60,
                right: 30,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: FadeInUp(
                              parentObject: this,
                              startDuration: Duration(milliseconds: 700),
                              child: ClayContainer(
                                height: 160,
                                width: 160,
                                depth: 20,
                                spread: 1,
                                color: Theme.of(context).primaryColorDark,
                                curveType: CurveType.convex,
                                borderRadius: 100,
                              ),
                            ),
                          ),
                          FadeInUp(
                            parentObject: this,
                            startDuration: Duration(milliseconds: 500),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Theme.of(context).primaryColorLight,
                                    Theme.of(context).primaryColor,
                                    Theme.of(context).primaryColorDark,
                                  ],
                                  radius: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      FadeInUp(
                        parentObject: this,
                        startDuration: Duration(milliseconds: 300),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Theme.of(context).primaryColor,
                                Theme.of(context).primaryColorDark,
                              ],
                              radius: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SafeArea(
              child: Center(
                child: Scrollbar(
                  showTrackOnHover: true,
                  radius: Radius.circular(10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                          ),
                          Center(
                            child: Container(
                              width: maxSize(size.width, 576),
                              child: RightFadeInRotateY(
                                parentObject: this,
                                size: 300,
                                startDuration: Duration(milliseconds: 600),
                                animationDuration: Duration(seconds: 1),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    'assets/images/welcome.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          FadeInDown(
                            parentObject: this,
                            startDuration: Duration(milliseconds: 700),
                            size: 30,
                            child: Center(
                              child: Container(
                                width: maxSize(size.width, 576),
                                child: RoundedButton(
                                  text: AppLocalizations.getTranslate("0001"),
                                  onPress: () {
                                    // TODO: OnClik
                                    nextPage();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Animasyonları geri döndürme bölümü
  /// The section for reverting animations
  Future<void> reverseAnimation() async {
    try {
      Library.globalData["widgetList"][screenCount]["animations"].forEach((k, v) async {
        switch (v["animationController"].status) {
          case AnimationStatus.completed:
            var s = v["startDuration"].toString().split('.')[0];
            var m = v["startDuration"].toString().split('.')[1];
            var x = int.parse(s.substring(s.length - 1) + "" + m) - 500000;
            x = x > 0 ? x : 0;
            Timer(Duration(microseconds: x), () async {
              await v["animationController"].reverse();
            });
            break;
          default:
        }
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  /// Animasyonları ileri döndürme bölümü
  /// The section for forwarding animations
  Future<void> forwardAnimation() async {
    try {
      Library.globalData["widgetList"][screenCount]["animations"].forEach((k, v) async {
        switch (v["animationController"].status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.reverse:
            Timer(v["startDuration"], () async {
              await v["animationController"].forward().orCancel;
            });
            break;
          default:
        }
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  void backPage() {
    try {
      /**
       * Set screen count
       */
      var x = parentObject.screenCount;

      /**
       * Reverse all animations
       */
      reverseAnimation();

      /**
       * Then back to previous page
       */
      Timer(Duration(milliseconds: 500), () {
        /**
         * Close this page first
         */
        Navigator.of(context).pop(this);

        /**
         * Print this page name
         */
        print("Back to " + Library.globalData["widgetList"][x]["name"]);

        /**
         * Run to forwardAnimation function in previous page
         */
        Library.globalData["widgetList"][x]["class"].forwardAnimation();
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  void nextPage() {
    /**
     * Reverse all animations
     */
    reverseAnimation();

    /**
     * After go to page
     */
    Timer(Duration(milliseconds: 500), () {
      Library.openNavigator(context, Library.globalData["StartScreen"], {"parentObject": this});
    });
  }
}
