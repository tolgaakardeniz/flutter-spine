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

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "RegisterScreen";
  late int screenCount;

  /// Form section
  final formKey = GlobalKey<FormState>();
  final nameAndSurname = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  Timer? formTimer;
  Timer? checkUserNameTimer;
  Timer? checkEmailTimer;

  IconData userNameCheckerIcon = Icons.person;
  IconData emailCheckerIcon = Icons.email_outlined;

  bool nameAndSurnameValidate = false;
  bool userNameValidate = false;
  bool emailValidate = false;
  bool passwordValidate = false;
  bool repeatPasswordValidate = false;

  FocusNode nameAndSurnameNode = FocusNode();
  FocusNode userNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode repeatPasswordNode = FocusNode(onKey: (node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      try {
        var x = Library.globalData["widgetNameList"]["RegisterScreen"].last;
        Library.globalData["widgetList"][x]["class"].submitRegister();
      } catch (e) {
        Library.debugPrint(e);
      }

      return true;
    }

    return false;
  });

  FocusNode userContractNode = FocusNode();

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
  void didUpdateWidget(covariant RegisterScreen oldWidget) {
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
     * Agreements
     */
    Library.globalData["userContract"] = false;
    Library.globalData["advertisingContract"] = false;

    /**
     * Login form
     */
    Library.globalData["isRegisterAttempt"] = false;

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
              SafeArea(
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
                                    'assets/images/register.jpg',
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
                                            submitRegister();
                                          },
                                          focusNode: nameAndSurnameNode,
                                          //autoFocus: true,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              nameAndSurnameValidate = false;
                                              return AppLocalizations.getTranslate("0066");
                                            } else if (!v.isValidNameAndSurname()) {
                                              nameAndSurnameValidate = false;
                                              return AppLocalizations.getTranslate("0068");
                                            }

                                            nameAndSurnameValidate = true;
                                            return null;
                                          },
                                          controller: nameAndSurname,
                                          hintText: AppLocalizations.getTranslate("0022"),
                                          labelText: AppLocalizations.getTranslate("0022"),
                                          icon: Icons.assignment_ind,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Consumer<Notifier>(
                                        builder: (context, notifier, child) {
                                          return RightFadeInRotateY(
                                            parentObject: this,
                                            startDuration: Duration(milliseconds: 300),
                                            child: RoundedInputField(
                                              textInputAction: TextInputAction.next,
                                              onFiledSubmitted: (v) {
                                                submitRegister();
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
                                                } else if (!userNameValidate) {
                                                  return AppLocalizations.getTranslate("0069");
                                                }

                                                userNameValidate = true;
                                                return null;
                                              },
                                              onChanged: (x) {
                                                userNameValidate = false;

                                                if (userNameCheckerIcon != Icons.timer) {
                                                  userNameCheckerIcon = Icons.timer;
                                                  notifier.callNotifyListeners();
                                                }

                                                checkUserNameTimer?.cancel();

                                                checkUserNameTimer = Timer(Duration(milliseconds: 1500), () {
                                                  checkUserName(x).then((x) {
                                                    userNameValidate = x;
                                                    if (x) {
                                                      userNameCheckerIcon = Icons.done;
                                                    } else {
                                                      userNameCheckerIcon = Icons.close;
                                                    }
                                                    notifier.callNotifyListeners();
                                                  });
                                                });
                                              },
                                              controller: userName,
                                              hintText: AppLocalizations.getTranslate("0002"),
                                              labelText: AppLocalizations.getTranslate("0002"),
                                              icon: userNameCheckerIcon,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Consumer<Notifier>(
                                        builder: (context, notifier, child) {
                                          return RightFadeInRotateY(
                                            parentObject: this,
                                            startDuration: Duration(milliseconds: 300),
                                            child: RoundedInputField(
                                              textInputAction: TextInputAction.next,
                                              onFiledSubmitted: (v) {
                                                submitRegister();
                                              },
                                              focusNode: emailNode,
                                              //autoFocus: true,
                                              validator: (v) {
                                                if (v == null || v.isEmpty) {
                                                  emailValidate = false;
                                                  return AppLocalizations.getTranslate("0062");
                                                } else if (!v.isValidEmail()) {
                                                  emailValidate = false;
                                                  return AppLocalizations.getTranslate("0014");
                                                } else if (!emailValidate) {
                                                  return AppLocalizations.getTranslate("0070");
                                                }

                                                emailValidate = true;
                                                return null;
                                              },
                                              onChanged: (x) {
                                                emailValidate = false;

                                                if (emailCheckerIcon != Icons.timer) {
                                                  emailCheckerIcon = Icons.timer;
                                                  notifier.callNotifyListeners();
                                                }

                                                checkEmailTimer?.cancel();

                                                checkEmailTimer = Timer(Duration(milliseconds: 1500), () {
                                                  checkEmail(x).then((x) {
                                                    emailValidate = x;
                                                    if (x) {
                                                      emailCheckerIcon = Icons.done;
                                                    } else {
                                                      emailCheckerIcon = Icons.close;
                                                    }
                                                    notifier.callNotifyListeners();
                                                  });
                                                });
                                              },
                                              controller: email,
                                              hintText: AppLocalizations.getTranslate("0023"),
                                              labelText: AppLocalizations.getTranslate("0023"),
                                              icon: emailCheckerIcon,
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 400),
                                        child: RoundedPasswordField(
                                          onFiledSubmitted: (v) {
                                            submitRegister();
                                          },
                                          focusNode: passwordNode,
                                          textInputAction: TextInputAction.next,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              passwordValidate = false;
                                              return AppLocalizations.getTranslate("0016");
                                            } else if (!v.isValidPassword()) {
                                              passwordValidate = false;
                                              return AppLocalizations.getTranslate("0018");
                                            }

                                            passwordValidate = true;
                                            return null;
                                          },
                                          controller: password,
                                          hintText: AppLocalizations.getTranslate("0003"),
                                          labelText: AppLocalizations.getTranslate("0003"),
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
                                            submitRegister();
                                          },
                                          focusNode: repeatPasswordNode,
                                          textInputAction: TextInputAction.done,
                                          validator: (v) {
                                            if (v == null || v.isEmpty) {
                                              repeatPasswordValidate = false;
                                              return AppLocalizations.getTranslate("0016");
                                            } else if (!v.isValidPassword()) {
                                              repeatPasswordValidate = false;
                                              return AppLocalizations.getTranslate("0018");
                                            } else if (v != password.text) {
                                              repeatPasswordValidate = false;
                                              return AppLocalizations.getTranslate("0067");
                                            }

                                            repeatPasswordValidate = true;
                                            FocusScope.of(context).unfocus();
                                            return null;
                                          },
                                          controller: repeatPassword,
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
                                              focusNode: userContractNode,
                                              value: Library.globalData["userContract"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  Library.globalData["userContract"] = newValue;
                                                });
                                              },
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Library.globalData["userContract"] = !Library.globalData["userContract"];
                                                  });
                                                },
                                                child: Text(AppLocalizations.getTranslate("0060")),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      RightFadeInRotateY(
                                        parentObject: this,
                                        startDuration: Duration(milliseconds: 600),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Checkbox(
                                              value: Library.globalData["advertisingContract"],
                                              onChanged: (newValue) {
                                                setState(() {
                                                  Library.globalData["advertisingContract"] = newValue;
                                                });
                                              },
                                            ),
                                            Flexible(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Library.globalData["advertisingContract"] = !Library.globalData["advertisingContract"];
                                                  });
                                                },
                                                child: Text(AppLocalizations.getTranslate("0061")),
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
                                          text: AppLocalizations.getTranslate("0058"),
                                          onPress: () {
                                            submitRegister();
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

  void submitRegister() async {
    /**
     * Validate returns true if the form is valid, or false otherwise.
     */
    formKey.currentState!.validate();

    /**
     * If all form elements are okay then run other actions
     */
    if (checkSubmit() && !Library.globalData["isRegisterAttempt"]) {
      /**
       * Multiple click blocker
       */
      Library.globalData["isRegisterAttempt"] = true;

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
          Library.globalData["isRegisterAttempt"] = false;
          closeLoadingDialog();
        },
      ).then((x) {
        Library.globalData["isRegisterAttempt"] = false;
      });

      Timer(Duration(milliseconds: 1), () {
        httpPost("setRegister/", {
          "nameAndSurname": nameAndSurname.text,
          "userName": userName.text,
          "email": email.text,
          "password": password.text,
          "repeatPassword": repeatPassword.text,
          "userContract": Library.globalData["userContract"].toString(),
        }).then((x) {
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
                    text: AppLocalizations.getTranslate("0063") + ", " + AppLocalizations.getTranslate("0071"),
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

          Library.globalData["isRegisterAttempt"] = false;
        }).then((x) {
          Library.globalData["isRegisterAttempt"] = false;
        });
      });

    }
  }

  /// Check all form for validate
  bool checkSubmit() {
    var x;

    if (!nameAndSurnameValidate) {
      x = nameAndSurnameNode;
    } else if (!userNameValidate) {
      x = userNameNode;
    } else if (!emailValidate) {
      x = emailNode;
    } else if (!passwordValidate) {
      x = passwordNode;
    } else if (!repeatPasswordValidate) {
      x = repeatPasswordNode;
    } else if (!Library.globalData["userContract"]) {
      x = userContractNode;
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

  Future<bool> checkUserName(String userName) async {
    var x = await httpPost("checkUserName/", {"userName": userName}).then((x) {
      try {
        if (x["return"]) {
          var y = getJson(utf8.decode(x["bodyBytes"]));

          if (y.runtimeType == String) {
            return false;
          } else {
            if (y["status"]) {
              return true;
            } else {
              return false;
            }
          }
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }).timeout(Duration(seconds: 25), onTimeout: () {
      throw (AppLocalizations.getTranslate("0009"));
    }).catchError((e, s) {
      return false;
    });

    return x;
  }

  Future<bool> checkEmail(String email) async {
    var x = await httpPost("checkEmail/", {"email": email}).then((x) {
      try {
        if (x["return"]) {
          var y = getJson(utf8.decode(x["bodyBytes"]));

          if (y.runtimeType == String) {
            return false;
          } else {
            if (y["status"]) {
              return true;
            } else {
              return false;
            }
          }
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }).timeout(Duration(seconds: 25), onTimeout: () {
      throw (AppLocalizations.getTranslate("0009"));
    }).catchError((e, s) {
      return false;
    });

    return x;
  }
}
