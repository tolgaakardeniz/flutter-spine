/*          initialRoute: '/',
          onGenerateRoute: _generatedRoutes,
          routes: {
            '/': (context) => WelcomeScreen(),
            '/WelcomeScreen': (context) => WelcomeScreen(),
          },*/

/*  Route _generatedRoutes(RouteSettings settings) {
    // implement business logic here
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
    }
  }*/












/*

try {
Library.globalData["animationController"].forEach((k, v) async {
switch (v["animationController"].status) {
case AnimationStatus.completed:
var s = v["startDuration"].toString().split('.')[0];
var m = v["startDuration"].toString().split('.')[1];
var x = int.parse(s.substring(s.length-1))-300000;
x = x>0?x:0;
Timer(
Duration(microseconds: x), () async {
await v["animationController"].reverse();
});
break;
default:
}
});
} catch (e) {
Library.debugPrint(e);
} on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
      print("sakdjşasjkfşadjfşsdjfşasdjfşlsadjfşadsjk");
    }
*/









/*
FadeInImage.assetNetwork(
placeholder: 'assets/images/placeholder.png', // Before image load
image: 'https://picsum.photos/id/237/200/300', // After image load
height: 200,
width: 300,
)*/
/*ListView.builder(
                                shrinkWrap: false,
                                itemCount: menuItems.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    */ /*sideBarIsOpen = false;*/ /*
                                    selectedMenuItem = index;
                                    sideBarState();
                                  },
                                  child: MenuItems(
                                    itemIcon: menuIcons[index],
                                    itemText: menuItems[index],
                                    position: index,
                                    selected: selectedMenuItem,
                                    menu: this,
                                  ),
                                ),
                              ),*/









/*            AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 1)
                  ..scale(pageScale),
                //..setEntry(3, 2, 0.001)..setEntry(0, 3, xOffset)..rotateY(20)
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 400),
                child: Padding(
                  padding: const EdgeInsets.only(right: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          offset: Offset(10, 10),
                          blurRadius: 30,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: !sideBarIsOpen
                          ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))
                          : BorderRadius.circular(30),
                      child: MainScreen(),
                    ),
                  ),
                ),
              ),*/
/*            AnimatedContainer(
                duration: Duration(microseconds: 1000),
                transform: Matrix4.translationValues(xOffset, yOffset, 1.0)
                  ..scale(pageScale),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: sideBarIsOpen
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(0),
                ),
                child: Container(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  sideBarIsOpen = !sideBarIsOpen;
                                  sideBarState();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.menu,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),*/
/*            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: tweenEnd),
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (_, double tweenMax, __) {
                  return (Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, xOffset * tweenMax)
                      ..rotateY(20),
                    child: Scaffold(
                      body: Container(
                      color: Colors.white,
                    ),
                    ),
                  ));
                },
              ),*/











/*  static bool isValidEmail(String email) => RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);*/

/*  Future<T> pushPage<T>(BuildContext context, Widget page) {
    return Navigator.of(context)
        .push<T>(MaterialPageRoute(builder: (context) => page));
  }
  */



/*                                                ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(content: Text('Processing Data')));*/









/*GridView.count(
                                crossAxisCount: SizeConfig(size).crossAxisCount,
                                //physics: NeverScrollableScrollPhysics(),
                                childAspectRatio: 1,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                padding: EdgeInsets.only(
                                    top: 40, bottom: 40, left: 20, right: 20),
                                children: [
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                  GridViewContainer(),
                                ],
                              ),*/


































/*[


                                              /// Material blue and Material light blue based theme.
                                              ThemChangerButton(text: "blue", flexScheme: FlexScheme.blue),

                                              /// Material indigo and Material deep purple based theme.
                                              ThemChangerButton(text: "indigo", flexScheme: FlexScheme.indigo),

                                              /// Hippie blue with surfie green and chock pink.
                                              ThemChangerButton(text: "hippieBlue", flexScheme: FlexScheme.hippieBlue),

                                              /// Aqua tropical blue ocean theme.
                                              ThemChangerButton(text: "aquaBlue", flexScheme: FlexScheme.aquaBlue),

                                              /// Blue theme composed of well known blue brand colors.
                                              ThemChangerButton(text: "brandBlue", flexScheme: FlexScheme.brandBlue),

                                              /// Deep blue dark abyss theme.
                                              ThemChangerButton(text: "deepBlue", flexScheme: FlexScheme.deepBlue),

                                              /// Pink sakura cherry blossom inspired theme.
                                              ThemChangerButton(text: "sakura", flexScheme: FlexScheme.sakura),

                                              /// Mandy red color and viking blue inspired theme.
                                              ThemChangerButton(text: "mandyRed", flexScheme: FlexScheme.mandyRed),

                                              /// Material red and Material pink theme.
                                              ThemChangerButton(text: "red", flexScheme: FlexScheme.red),

                                              /// Red wine inspired theme.
                                              ThemChangerButton(text: "redWine", flexScheme: FlexScheme.redWine),

                                              /// Purple brown, aubergine and eggplant inspired theme.
                                              ThemChangerButton(text: "purpleBrown", flexScheme: FlexScheme.purpleBrown),

                                              /// Material green forest and Material teal based theme.
                                              ThemChangerButton(text: "green", flexScheme: FlexScheme.green),

                                              /// Green money theme, as in "show me the money theme".
                                              ThemChangerButton(text: "money", flexScheme: FlexScheme.money),

                                              /// Lush green jungle inspired theme.
                                              ThemChangerButton(text: "jungle", flexScheme: FlexScheme.jungle),

                                              /// Somber Material blue-grey and legal purple and grey theme.
                                              ThemChangerButton(text: "greyLaw", flexScheme: FlexScheme.greyLaw),

                                              /// Wild willow and wasabi green with orchid purple inspired theme.
                                              ThemChangerButton(text: "wasabi", flexScheme: FlexScheme.wasabi),

                                              /// Gold sunset inspired theme.
                                              ThemChangerButton(text: "gold", flexScheme: FlexScheme.gold),

                                              /// Playful mango mojito theme.
                                              ThemChangerButton(text: "mango", flexScheme: FlexScheme.mango),

                                              /// Material amber and blue accent based theme.
                                              ThemChangerButton(text: "amber", flexScheme: FlexScheme.amber),

                                              /// Vesuvius burned orange and eden green based theme.
                                              ThemChangerButton(text: "vesuviusBurn", flexScheme: FlexScheme.vesuviusBurn),

                                              /// Deep purple, daisy bush theme.
                                              ThemChangerButton(text: "deepPurple", flexScheme: FlexScheme.deepPurple),

                                              /// Ebony clay deep blue grey and watercourse green theme.
                                              ThemChangerButton(text: "ebonyClay", flexScheme: FlexScheme.ebonyClay),

                                              /// Barossa red and cardin green theme.
                                              ThemChangerButton(text: "barossa", flexScheme: FlexScheme.barossa),

                                              /// Shark grey and orange ecstasy theme.
                                              ThemChangerButton(text: "shark", flexScheme: FlexScheme.shark),

                                              /// Big stone blue and tulip tree yellow theme.
                                              ThemChangerButton(text: "bigStone", flexScheme: FlexScheme.bigStone),

                                              /// Damask red and lunar green theme.
                                              ThemChangerButton(text: "damask", flexScheme: FlexScheme.brandBlue),
                                            ]*/







/*                                Visibility(
                                  visible: !isLoginAttempt,*/



















/*

class User {
  String name;
  int age;

  User(this.name, this.age);

  factory User.fromJson(dynamic json) {
    return User(json['name'] as String, json['age'] as int);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.age} }';
  }
}*/




/*







Solution
/libs/extensions/map.dart

extension ListFromMap<Key, Element> on Map<Key, Element> {
  List<T> toList<T>(
          T Function(MapEntry<Key, Element> entry) getElement) =>
      entries.map(getElement).toList();
}
Usage
import 'package:myApp/libs/extensions/map.dart';

final map = {'a': 1, 'b': 2};
print(map.toList((e) => e.value));
print(map.toList((e) => e.key));





 */
/*



Future<Widget> checkLogin(context) async {
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

    return MainScreen();
  } catch (e) {
    return WelcomeScreen();
  }
}

/// Get user information from in system storage data
get getStorageUserInfo async {
  var userInfo = await StorageManager.readData("lastUser");
  var userId = await StorageManager.readData("lastUserId");

  userInfo = getJson(userInfo);

  if (!userInfo.runtimeType.toString().contains("HashMap")) {
    userInfo = null;
    userId = null;
  }

  Library.globalData["userInfo"] = userInfo;
  Library.globalData["userId"] = userId;

  Map<String, dynamic> x = {"userId": userId, "userInfo": userInfo};

  return x;
}
*/






/*    return Consumer<Notifier>(
      builder: (context, themeNotifier, child) {*/

/**
 * Evrensel veri listesine themeNotifier nesnesini ekledik
 */
/*        Library.globalData["Notifier"] = themeNotifier;*/

/*      },
    );*/




/*      initialRoute: '/',
      routes: {
        '/': (context) => Root(),
        '/WelcomeScreen': (context) => WelcomeScreen(),
        '/MainScreen': (context) => MainScreen(),
      },*/





/*    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (Library.globalData["WelcomeScreen"]["status"] == ScreenStatus.active) {
        timer.cancel();
        checkLogin();
      }
    });*/





/*

home: FutureBuilder(
future: getStorageUserInfo,
builder: (context, snapshot) {
if (snapshot.data != null && Library.globalData["Loading"].containsKey("toRun")) {
return Library.globalData["Loading"]["toRun"];
} else {
return Loading();
}

switch (snapshot.connectionState) {
case ConnectionState.waiting:
return Loading();
case ConnectionState.done:
if (snapshot.hasError) {
//return Text('Error: ${snapshot.error}');

return WelcomeScreen();
} else {
//return Text('Result: ${snapshot.data}');
return MainScreen();
}
default:

return WelcomeScreen();
}
},
),*/













/*
child: Listener(
onPointerDown: (event) {
nextPage(Library.globalData["RememberScreen"]);
},
child: Text(
AppLocalizations.getTranslate("0057"),
overflow: TextOverflow.ellipsis,
),
),*/