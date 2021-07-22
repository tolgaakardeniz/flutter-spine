/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';
import 'dart:convert';

import 'package:spine/animations/FadeInDown.dart';
import 'package:spine/animations/RightFadeInRotateY.dart';
import 'package:spine/clippers/background.dart';
import 'package:spine/components/DrawerMenu.dart';
import 'package:spine/components/GridViewContainer.dart';
import 'package:spine/components/SlideMenu.dart';
import 'package:spine/components/ThemeSelectMenu.dart';
import 'package:spine/constants.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/components/addShadow.dart';
import 'package:spine/themes/default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/MainScreen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with RouteAware, SingleTickerProviderStateMixin {
  final GlobalKey _topMenuKey = GlobalKey();
  late dynamic parentObject;
  final String screenName = "MainScreen";
  late int screenCount;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<String, dynamic> mapList = {};
  List<Map> listList = [];
  bool isRequestSent = false;

  late AnimationController themeSelectMenuAnimationController;
  late Animation<double> themeSelectAnimation;
  bool themeSelectIsOpen = false;
  bool themeMenuVisible = true;
  double themeMenuRight = 10;
  double themeMenuTop = 90;

  Future<List<Map>> fetchPost() async {
    /**
     * Listeyi temizle
     */
    listList.clear();

    late final http.Response response;

    try {
      response = await http.get(
        Uri.parse("https://gist.githubusercontent.com/dpetersen/1237910/raw/80492f9a2dcadd5c0d26e5aaac3dc98fef7895a4/product_grid.js"),
        headers: {'Content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> values = json.decode(response.body);

        //final map = Map<String, dynamic>.from(k);
        //map.addAll({"id":1, "Product" : elem["product-name"]});
/*      values["CO"].toList().forEach((key) {
        mapEkleme.putIfAbsent("Product", () => key["product-name"]);
        mapEkleme.addEntries({MapEntry(key["product-name"], key["product-name"])});
        Library.debugPrint(key["product-name"]);*/

        values["CO"].toList().forEach((key) {
          listList.insert(listList.length, {"id": listList.length, "name": key["product-name"], "image": key["product-image-url"]});
        });

        values["WI"].toList().forEach((key) {
          listList.insert(listList.length, {"id": listList.length, "name": key["product-name"], "image": key["product-image-url"]});
        });
      } else {
        throw (response.statusCode.toString() + " " + response.reasonPhrase.toString());
      }
    } catch (e) {
      throw (AppLocalizations.getTranslate("0010") + ": " + e.toString());
    }

    return listList;
  }

  Widget? closeDrawerMenu() {
    /**
     * If is open Drawer menu? Close.
     */
    if (_scaffoldKey.currentState != null) {
      if (_scaffoldKey.currentState!.isDrawerOpen) {
        _scaffoldKey.currentState!.openEndDrawer();
      }
    }

    return null;
  }

  void closeThemeMenu() {
    if (themeSelectIsOpen) {
      themeSelectIsOpen = false;
      themeSelectMenuAnimationController.reverse();
    }

    refreshState();
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
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush: " + screenName);
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPopNext: " + screenName);

    /**
     * Menü seçilmiş öğe
     */
    Library.globalData["selectedMenuItem"] = 0;

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
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget == oldWidget) {
      // TODO: start a transition between the previous and new value
    }

    print("didUpdateWidget: " + screenName);
  }

  /// Position Detector
  Map<dynamic, dynamic> getSizeAndPosition() {
    RenderBox _topMenuBox = _topMenuKey.currentContext!.findRenderObject() as RenderBox;

    return {"size": _topMenuBox.size, "position": _topMenuBox.localToGlobal(Offset.zero)};
  }

  @override
  void initState() {
    super.initState();

    themeSelectMenuAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    themeSelectAnimation = Tween(begin: 0.0, end: 1.0).animate(themeSelectMenuAnimationController);

    /// Position Detector
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => getSizeAndPosition());


    isRequestSent = true;

    ///Grid için veri çek

    fetchPost().then((value) {
      isRequestSent = false;
      refreshState();
    }).catchError((error, stackTrace) {
      Library.debugPrint(error);
      Library.debugPrint(stackTrace);
      showCustomDialog(context: context, text: error.toString());

      refreshState();
    });

    /**
     * Menü bilgileri
     * Menu information's
     */

    /**
     * Memü açık/kapalı
     */
    Library.globalData["sideBarIsOpen"] = true;

    /**
     * Menü seçilmiş öğe
     */
    Library.globalData["selectedMenuItem"] = 0;

    /**
     * Menü isimleri
     */
    Library.globalData["menuItems"] = ["0011", "0012"];

    /**
     * Menü simgeleri
     */
    Library.globalData["menuIcons"] = <IconData>[Icons.home, Icons.settings];

    /**
     * Menü tıklamalarında
     */
    Library.globalData["menuOnClick"] = <Function>[
      () {
        closeDrawerMenu();

        print("WelcomeScreen click menu");
      },
      () {
        closeThemeMenu();
        closeDrawerMenu();

        reverseAnimation();

        Timer(Duration(milliseconds: 500), () {
          Library.openNavigator(context, Library.globalData["SettingsScreen"], {"parentObject": this});
        });
      },
      () {
        closeThemeMenu();
        closeDrawerMenu();
        StorageManager.deleteData("lastUser");
        StorageManager.deleteData("lastUserId");
        Provider.of<Notifier>(context, listen: false).isLoggedIn = LoginStatus.welcomeScreen;
        backPage();
      }
    ];

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
        key: _scaffoldKey,
        drawer: (SizeConfig(size).crossAxisCount < 2)
            ? ClipShadowPath(
                clipper: DrawerClipper(),
                shadow: Shadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(10, 0),
                  blurRadius: 10,
                ),
                child: DrawerMenu(),
              )
            : closeDrawerMenu(),
        body: Stack(
          fit: StackFit.expand,
          children: [
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
            Center(
              child: Container(
                width: maxSize(size.width, 1440),
                child: Row(
                  children: [
                    if (SizeConfig(size).crossAxisCount > 1)
                      Menu(
                        parentObject: this,
                      ),
                    Expanded(
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                LimitedBox(
                                  maxHeight: 80,
                                  // TODO: Üst menü
                                  child: FadeInDown(
                                    parentObject: this,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                        color: Theme.of(context).primaryColorDark,
                                      ),
                                      margin: EdgeInsets.all(10),
                                      /*padding: EdgeInsets.only(top:10,bottom: 10,),*/
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerRight,
                                            child: Tooltip(
                                              message: AppLocalizations.getTranslate("0005"),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  backPage();
                                                },
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shape: CircleBorder(),
                                                  padding: EdgeInsets.all(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Container() /*ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: FlexScheme.values.where((e) => (FlexScheme.custom == e ? false : true)).map((e) {
                                                var y = (e).toString().split(".")[1];

                                                try {
                                                  y = FlexColor.schemes[e]!.name;
                                                } catch (e)
                                                {
                                                  y = "Özel Tanımlanan";
                                                }

                                                return ThemChangerButton(text: y, flexScheme: e);
                                              }).toList(),
                                            ),*/
                                          ),
                                          Container(
                                            key: _topMenuKey,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: () {
/*                                                Map<dynamic, dynamic> x = getSizeAndPosition();
                                                if (x.containsKey("size") && x.containsKey("position"))
                                                {
                                                  themeMenuRight = (size.width - x["position"].dx) - x["size"].width;
                                                  themeMenuTop = x["position"].dy + x["size"].height + 10;

                                                }*/

                                                themeMenu();

/*                                                _scaffoldKey.currentState!.openDrawer();*/

                                              },
                                              child: Icon(
                                                Icons.menu,
                                                color: Colors.white,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                //primary: kPrimaryLightColor,
                                                //onPrimary: kPrimaryColor,
                                                shape: CircleBorder(),
                                                padding: EdgeInsets.all(15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RightFadeInRotateY(
                                    parentObject: this,
                                    size: 200,
                                    child: Listener(
                                      onPointerDown: (e) {
                                        closeThemeMenu();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(38),
                                          child: Container(
                                            color: Theme.of(context).primaryColorLight,
                                            child: GridView.builder(
                                              scrollDirection: Axis.vertical,
                                              padding: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: listList.length > 0 ? SizeConfig(size).crossAxisCount : 2,
                                                childAspectRatio: 1,
                                                mainAxisSpacing: 20,
                                                crossAxisSpacing: 20,
                                              ),
                                              itemCount: listList.length,
                                              itemBuilder: (BuildContext context, index) {
                                                return GridViewContainer(
                                                  text: listList[index]["name"],
                                                  image: listList[index]["image"] ?? "https://i.stack.imgur.com/jq2eV.png?s=328&g=1",
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              right: themeMenuRight,
                              top: themeMenuTop,
                              child: AnimatedBuilder(
                                animation: themeSelectAnimation,
                                builder: (BuildContext context, Widget? child) {
                                  if (themeSelectAnimation.status == AnimationStatus.dismissed) {
                                    themeMenuVisible = false;
                                  } else {
                                    themeMenuVisible = true;
                                  }
                                  return Transform.translate(
                                    child: Opacity(
                                      opacity: themeSelectAnimation.value,
                                      child: Transform.translate(
                                        offset: Offset(0, 25 - (25 * (themeSelectAnimation.value * -1).abs())),
                                        child: Visibility(
                                          visible: themeMenuVisible,
                                          child: ThemeSelectMenu().addShadow(blurRadius: 20, borderRadius: 0),
                                        ),
                                      ),
                                    ),
                                    offset: Offset(0, 25 - (25 * (themeSelectAnimation.value * -1).abs())),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool themeMenu() {
    themeSelectIsOpen = !themeSelectIsOpen;

    if (themeSelectIsOpen)
      themeSelectMenuAnimationController.forward();
    else
      themeSelectMenuAnimationController.reverse();

    refreshState();

    return themeSelectIsOpen;
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
      var x = parentObject.screenCount;

      reverseAnimation();

      Timer(Duration(milliseconds: 500), () {
        Navigator.of(context).pop(this);

        print("Back to " + Library.globalData["widgetList"][x]["name"]);
        try {
          Library.globalData["widgetList"][x]["class"].forwardAnimation();
        } catch (e) {
          Library.debugPrint(e);
        }
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }
}

// TODO: Json dosyadan albüm alma

/// Uzak sunucudan json bilgi alma ardından istenen sınıf ile liste oluşturma

Future<Album> fetchAlbum() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

/*
class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
 */
