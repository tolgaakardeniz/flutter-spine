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
import 'package:spine/components/RoundedPasswordField.dart';
import 'package:spine/themes/default.dart';
import 'package:spine/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:spine/constants.dart';
import 'package:spine/localizations.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  static const routeName = '/StartScreen';

  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "StartScreen";
  late int screenCount;

  /// Form section
  final formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();

  Timer? formTimer;

  bool userNameValidate = false;
  bool passwordValidate = false;

  FocusNode userNameNode = FocusNode();
  FocusNode passwordNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      try {
        var x = Library.globalData["widgetNameList"]["StartScreen"].last;
        Library.globalData["widgetList"][x]["class"].submitLogin();
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
  void didUpdateWidget(covariant StartScreen oldWidget) {
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
     * Login form
     */
    Library.globalData["isLoginAttempt"] = false;

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
        /*resizeToAvoidBottomInset: false,*/
        body: Stack(
          fit: StackFit.expand,
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
                            height: 50,
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
                                    'assets/images/login.jpg',
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
                                          textInputAction: TextInputAction.next,
                                          onFiledSubmitted: (v) {
/*                                                  FocusScope.of(context).nextFocus();*/
                                            FocusScope.of(context).requestFocus(passwordNode);
                                          },
                                          focusNode: userNameNode,
                                          //autoFocus: true,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              userNameValidate = false;
                                              return AppLocalizations.getTranslate("0015");
                                            } else if (!v.isValidUserName()) {
                                              userNameValidate = false;
                                              return AppLocalizations.getTranslate("0019") + " " + AppLocalizations.getTranslate("0020");
                                            }

                                            userNameValidate = true;
                                            return null;
                                          },
                                          controller: userName,
                                          hintText: AppLocalizations.getTranslate("0002"),
                                          labelText: AppLocalizations.getTranslate("0002"),
                                          icon: Icons.person,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 400),
                                        child: RoundedPasswordField(
                                          onFiledSubmitted: (v) {
                                            FocusScope.of(context).unfocus();
                                            submitLogin();
                                          },
                                          focusNode: passwordNode,
                                          textInputAction: TextInputAction.done,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              passwordValidate = false;
                                              return AppLocalizations.getTranslate("0016");
                                            } else if (!v.isValidPassword()) {
                                              passwordValidate = false;
                                              return AppLocalizations.getTranslate("0018");
                                            }

                                            passwordValidate = true;
                                            FocusScope.of(context).unfocus();
                                            return null;
                                          },
                                          controller: password,
                                          hintText: AppLocalizations.getTranslate("0003"),
                                          labelText: AppLocalizations.getTranslate("0003"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 500),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              value: Library.globalData["remember"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  Library.globalData["remember"] = newValue;
                                                });

                                                StorageManager.saveData("remember", Library.globalData["remember"]);
                                              },
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Library.globalData["remember"] = !Library.globalData["remember"];
                                                  });

                                                  StorageManager.saveData("remember", Library.globalData["remember"]);
                                                },
                                                child: Text(
                                                  AppLocalizations.getTranslate("0056"),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 500),
                                        child: RoundedButton(
                                          text: AppLocalizations.getTranslate("0004"),
                                          onPress: () {
                                            submitLogin();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 600),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  nextPage(Library.globalData["RememberScreen"]);
                                                },
                                                child: Text(
                                                  AppLocalizations.getTranslate("0057"),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  nextPage(Library.globalData["RegisterScreen"]);
                                                },
                                                child: Text(
                                                  AppLocalizations.getTranslate("0058"),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
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

  void nextPage([String? pageName]) {
    /**
     * Deactivate focus on elements.
     */
    FocusScope.of(context).unfocus();

    /**
     * Reverse all animations
     */
    reverseAnimation();

    /**
     * After go to page
     */
    Timer(Duration(milliseconds: 1000), () {
      Library.openNavigator(context, pageName ?? Library.globalData["MainScreen"], {"parentObject": this});
    });
  }

  void submitLogin() async {
    /**
     * Validate returns true if the form is valid, or false otherwise.
     */
    formKey.currentState!.validate();

    /**
     * If all form elements are okay then run other actions
     */
    if (checkSubmit() && !Library.globalData["isLoginAttempt"]) {
      /**
       * Multiple click blocker
       */
      Library.globalData["isLoginAttempt"] = true;

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
          Library.globalData["isLoginAttempt"] = false;
          closeLoadingDialog();
        },
      ).then((x) {
        Library.globalData["isLoginAttempt"] = false;
      });

      Timer(Duration(milliseconds: 1), () {
        User.getLogin(userName.text, password.text).then((x) {
          closeLoadingDialog();

          try {
            if (x["return"]) {
              /**
               * {Islem: 1, Ref: 1, Adi: admin, Parola: QFBhcm9sYQ==, Kunye: Sistem Yöneticisi, Posta: ocalcem@gmail.com, Kontrol: 9430ddf343c2b226047b93f445eab23e, Pasif: null, KullaniciTuru: 5, OlusturanRef: 1, Ip: 127.0.0.1, OlusturmaTarihi: 2020-04-15 20:53:40, KullaniciRef: 1, PostaOnay: null, Cinsiyet: null, Vatandas: null, Dogum: 2021-05-05, Telefon: null, Goruntu: {"Arka": "/tmp/back/2021.05.06/1/34dkLrv.jpg", "Profil": "/tmp/profile/2021.05.07/1/34dkLrv.jpg"}, Bilgi: Deneme mesajıdır. Deneme için yapılmıştır., Urun: null, Puan: null, Begeni: null, Takipci: null, Takip: null, Profil: 194, Giris: 161, Cikis: 3, Durum: null, OturumTarihi: 2021-06-22 14:02:58, CikisTarihi: 2021-06-17 15:12:00, SonAktivite: 2021-04-05 12:32:34, Yetkisi: f60fa90a811603110aa9acdbc3ce4d8e}}
               */
              var y = x["userInfo"];

              Provider.of<Notifier>(context, listen: false).user = User(
                  id: int.parse(y["Ref"]),
                  userName: y["Adi"],
                  password: password.text,
                  firstName: y["Kunye"],
                  lastName: y["Kunye"],
                  email: y["Posta"],
                  active: (y["Pasif"] == null) ? 0 : 1,
                  createdTime: DateTime.parse(y["OturumTarihi"]));

              Map<String, dynamic> avatarInfo;

              if (y["Goruntu"].isNotEmpty) {
                avatarInfo = getJson(y["Goruntu"]);

                if (avatarInfo.containsKey("Profil")) {
                  Provider.of<Notifier>(context, listen: false).user = Provider.of<Notifier>(context, listen: false).user.copyWith(
                        avatar: httpAddress + avatarInfo["Profil"],
                      );
                }
                if (avatarInfo.containsKey("Arka")) {
                  Provider.of<Notifier>(context, listen: false).user = Provider.of<Notifier>(context, listen: false).user.copyWith(
                        background: httpAddress + avatarInfo["Arka"],
                      );
                }
              }

              try {
                StorageManager.saveData(
                  "lastUser",
                  json.encode(Users.userList[Users.activeUser], toEncodable: (x) => x.toString()),
                );
                StorageManager.saveData("lastUserId", Users.activeUser.toString());
              } catch (e) {
                Library.debugPrint(e);
              }

              nextPage();
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

          Library.globalData["isLoginAttempt"] = false;
        }).then((x) {
          Library.globalData["isLoginAttempt"] = false;
        });
      });
    }
  }

  /// Check all form for validate
  bool checkSubmit() {
    var x;

    if (!userNameValidate) {
      x = userNameNode;
    } else if (!passwordValidate) {
      x = passwordNode;
    }

    formTimer?.cancel();

    formTimer = Timer(Duration(milliseconds: 10), () {
      if (x.runtimeType == FocusNode) {
        FocusScope.of(context).requestFocus(x);
      }
    });

    if (x.runtimeType == FocusNode) {
      return false;
    }

    return true;
  }
}