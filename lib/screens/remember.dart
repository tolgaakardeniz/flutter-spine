/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';
import 'dart:convert';

import 'package:clay_containers/clay_containers.dart';
import 'package:spine/animations/FadeInDown.dart';
import 'package:spine/animations/FadeInLeft.dart';
import 'package:spine/animations/RightFadeInRotateY.dart';
import 'package:spine/clippers/background.dart';
import 'package:spine/data/library.dart';
import 'package:spine/components/RoundedButton.dart';
import 'package:spine/components/RoundedInputField.dart';
import 'package:spine/themes/default.dart';
import 'package:spine/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:spine/constants.dart';
import 'package:spine/localizations.dart';
import 'package:provider/provider.dart';

class RememberScreen extends StatefulWidget {
  static const routeName = '/RememberScreen';

  const RememberScreen({Key? key}) : super(key: key);

  @override
  State<RememberScreen> createState() => _RememberScreenState();
}

class _RememberScreenState extends State<RememberScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "RememberScreen";
  late int screenCount;

  /// Form section
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  FocusNode emailNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      try {
        var x = Library.globalData["widgetNameList"]["RememberScreen"].last;
        Library.globalData["widgetList"][x]["class"].submitRemember();
      } catch (e) {
        Library.debugPrint(e);
      }

      return true;
    }

    return false;
  });

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
  void didUpdateWidget(covariant RememberScreen oldWidget) {
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
     * Remember form
     */
    Library.globalData["isRememberAttempt"] = false;

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

    /**
     * User Is login goto back page
     */
    if (Provider.of<Notifier>(context).isLoggedIn == LoginStatus.mainScreen) {
      backPage();
    }

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
        /*resizeToAvoidBottomInset: false,*/
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: FadeInDown(
                  parentObject: this,
                  startDuration: Duration(milliseconds: 0),
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
              Scrollbar(
                showTrackOnHover: true,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInLeft(
                          parentObject: this,
                          startDuration: Duration(milliseconds: 400),
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
/*                              canRequestFocus: false,*/
                                  onTap: () {
                                    backPage();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Theme.of(context).indicatorColor,
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: FadeInDown(
                            parentObject: this,
                            startDuration: Duration(milliseconds: 400),
                            child: Container(
                              width: maxSize(size.width, 576),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/forgot.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Form(
                          key: formKey,
                          child: Center(
                            child: FadeInDown(
                              parentObject: this,
                              startDuration: Duration(milliseconds: 100),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).backgroundColor,
                                ),
                                width: maxSize(size.width, 576),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RightFadeInRotateY(
                                      parentObject: this,
                                      startDuration: Duration(milliseconds: 300),
                                      child: RoundedInputField(
                                        textInputAction: TextInputAction.done,
                                        onFiledSubmitted: (v) {
                                          submitRemember();
                                        },
                                        focusNode: emailNode,
                                        //autoFocus: true,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            FocusScope.of(context).requestFocus(emailNode);
                                            return AppLocalizations.getTranslate("0062");
                                          } else if (!v.isValidEmail()) {
                                            FocusScope.of(context).requestFocus(emailNode);
                                            return AppLocalizations.getTranslate("0014");
                                          }

                                          FocusScope.of(context).unfocus();
                                          return null;
                                        },
                                        controller: email,
                                        hintText: AppLocalizations.getTranslate("0023"),
                                        labelText: AppLocalizations.getTranslate("0023"),
                                        icon: Icons.email_outlined,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    RightFadeInRotateY(
                                      parentObject: this,
                                      startDuration: Duration(milliseconds: 500),
                                      child: RoundedButton(
                                        text: AppLocalizations.getTranslate("0059"),
                                        onPress: () {
                                          submitRemember();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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
            ],
          ),
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
       * Deactivate focus on elements.
       */
      FocusScope.of(context).unfocus();

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

  void submitRemember() async {
    /**
     * Validate returns true if the form is valid, or false otherwise.
     */
    if (formKey.currentState!.validate() && !Library.globalData["isRememberAttempt"]) {
      /**
       * Multiple click blocker
       */
      Library.globalData["isRememberAttempt"] = true;

      /**
       * Set save form state
       */
      formKey.currentState!.save();

      /**
       * Deactivate focus on elements.
       */
      FocusScope.of(context).unfocus();

      showLoadingDialog<bool>(
        context: context,
        child: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Image(image: ExactAssetImage("assets/images/loadin.gif"),fit: BoxFit.cover, height: 64,),*/
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                SelectableText(
                  AppLocalizations.getTranslate("0017"),
                  textAlign: TextAlign.center,
                  style: Library.textStyle.copyWith(color: Theme.of(context).indicatorColor),
                ),
              ],
            ),
          ),
        ),
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          Library.globalData["isRememberAttempt"] = false;
          closeLoadingDialog();
        },
      ).then((x) {
        Library.globalData["isRememberAttempt"] = false;
      });

      Timer(Duration(milliseconds: 1), () {
        httpPost("getPassword/", {"email": email.text}).then((x) {
          closeLoadingDialog();

          try {
            if (x["return"]) {
              var y = getJson(utf8.decode(x["bodyBytes"]));

              if (y.runtimeType == String)
                {
                  x["return"] = false;
                  x["error"] = y;
                } else {
                if (y["status"]) {
                  showCustomDialog(
                    context: context,
                    text: AppLocalizations.getTranslate("0063") + ", " + AppLocalizations.getTranslate("0064") + " " + AppLocalizations.getTranslate("0065"),
                  ).then((v) {
                    backPage();
                  }).onError((error, stackTrace) {
                    backPage();
                  });

                  return;
                } else {
                  if (y.containsKey("errorCount")) {
                    if (y["errorCount"] > 0) {
                      y = y["errors"].join("\n");
                    }
                  } else {
                    y = utf8.decode(x["bodyBytes"]);
                  }

                  x["return"] = false;
                  x["error"] = y;
                }
              }

              showCustomDialog(
                context: context,
                text: x["error"],
              );
            } else {
              showCustomDialog(
                context: context,
                text: x["error"],
              );
            }
          } catch (e) {
            showCustomDialog(
              context: context,
              text: e.toString(),
            );
          }
        }).onError((error, stackTrace) {
          closeLoadingDialog();

          showCustomDialog(
            context: context,
            text: Library.globalData["debugMode"] ? error.toString() + " " + stackTrace.toString() : error.toString(),
          );

          Library.globalData["isRememberAttempt"] = false;
        }).then((x) {
          Library.globalData["isRememberAttempt"] = false;
        });
      });
    }
  }
}
