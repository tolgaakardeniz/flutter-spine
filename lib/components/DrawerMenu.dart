/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/animations/RightFadeInRotateY.dart';
import 'package:spine/components/ImageLoader.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(200, 0);
    path.quadraticBezierTo(size.width * 1.2, size.height / 2, 200, size.height);
    path.lineTo(0, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class DrawerMenu extends StatefulWidget {
  final List<String>? menuItems;
  final List<IconData>? menuIcons;

  const DrawerMenu({Key? key, this.menuItems, this.menuIcons}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final String screenName = "DrawerMenu";
  final List<String> menuItems = Library.globalData["menuItems"];
  final List<IconData> menuIcons = Library.globalData["menuIcons"];
  final List<Function> menuOnClick = Library.globalData["menuOnClick"];

  int selectedMenuItem = Library.globalData["selectedMenuItem"];
  bool sideBarIsOpen = false;

  void sideBarState() {
    setState(() {
      selectedMenuItem = Library.globalData["selectedMenuItem"];
    });
  }

  @override
  void initState() {
    super.initState();

    /**
     * Aktif wiget adı
     */
    Library.globalData["activeScreenName"] = screenName;

    /**
     * Ana widget sınıfını widgets listesinin içine ekle
     * Add this widget in widgets map lists
     */
    Library.globalData[screenName] = Map<String, dynamic>();
    Library.globalData[screenName]["class"] = this;

    /**
     * Screen status
     */
    Library.globalData[screenName]["status"] = ScreenStatus.active;

    print("initState: " + screenName);
  }

  @override
  void dispose() {
    print("dispose: " + screenName);

    Library.globalData.remove(screenName);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Screen status
     */
    Library.globalData[screenName]["status"] = ScreenStatus.active;

    /**
     * Screen size information
     */
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
/*        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),*/
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColorLight,
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColorDark,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
/*        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],*/
      ),
      child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              width: 256,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut,
                                  /*padding: EdgeInsets.only(left: 5),*/
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (Provider.of<Notifier>(context).user.avatar != null)
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                          width: 200,
                                          height: 150,
                                          child: ImageLoader(
                                            imageUrl: Provider.of<Notifier>(context).user.avatar.toString(),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.white.withOpacity(0.7),
                                                width: 7,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.5),
                                                  offset: Offset(1.0, 6.0),
                                                  blurRadius: 40.0,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (Provider.of<Notifier>(context).user.avatar == null)
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/gradient.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Container(
                                          child: Consumer<Notifier>(
                                            builder: (context, x, child) => Text(
                                              x.user.userName,
                                              style: Library.textStyle.copyWith(
                                                fontWeight: FontWeight.w900,
                                                color: Theme.of(context).indicatorColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          child: Consumer<Notifier>(
                                            builder: (context, x, child) => Text(
                                              x.user.lastName,
                                              style: Library.textStyle.copyWith(
                                                color: Theme.of(context).indicatorColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                for (int x = 0; x < menuItems.length; x++)
                                  DrawerMenuItems(
                                    itemIcon: menuIcons[x],
                                    itemText: menuItems[x],
                                    position: x,
                                    selected: Library.globalData["selectedMenuItem"],
                                    menu: this,
                                    onClick: menuOnClick[x],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: DrawerMenuItems(
                      itemIcon: Icons.logout,
                      itemText: "0013",
                      position: menuItems.length,
                      selected: Library.globalData["selectedMenuItem"],
                      menu: this,
                      onClick: menuOnClick[menuItems.length],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerMenuItems extends StatelessWidget {
  final String itemText;
  final IconData itemIcon;
  final int selected;
  final int position;
  final dynamic menu;
  final Function? onClick;

  const DrawerMenuItems({
    Key? key,
    required this.itemText,
    required this.itemIcon,
    required this.selected,
    required this.position,
    required this.menu,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      onHover: (event) {
        //menu.sideBarState();
      },
      hoverChild: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Library.globalData["selectedMenuItem"] = position;
                menu.sideBarState();

                if (onClick != null) {
                  onClick!();
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        itemIcon,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.getTranslate(itemText),
                        style: TextStyle(color: Theme.of(context).indicatorColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: RightFadeInRotateY(
          parentObject: this,
          startDuration: Duration(milliseconds: (50 * position)),
          animationDuration: Duration(milliseconds: 700),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Library.globalData["selectedMenuItem"] = position;
                  menu.sideBarState();

                  if (onClick != null) {
                    onClick!();
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  color: selected == position ? Theme.of(context).primaryColorDark : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          itemIcon,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.getTranslate(itemText),
                          style: TextStyle(color: Theme.of(context).indicatorColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
