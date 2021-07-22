/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/animations/FadeInLeft.dart';
import 'package:spine/animations/RightFadeInRotateY.dart';
import 'package:spine/components/ImageLoader.dart';
import 'package:spine/constants.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/themes/default.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final dynamic parentObject;

  const Menu({Key? key, required this.parentObject}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<String> menuItems = Library.globalData["menuItems"];
  final List<IconData> menuIcons = Library.globalData["menuIcons"];
  final List<Function> menuOnClick = Library.globalData["menuOnClick"];
  int selectedMenuItem = Library.globalData["selectedMenuItem"];
  bool sideBarIsOpen = Library.globalData["sideBarIsOpen"];

  void sideBarState() {
    setState(() {
      selectedMenuItem = Library.globalData["selectedMenuItem"];
      sideBarIsOpen = Library.globalData["sideBarIsOpen"];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Screen size information
     */
    Size size = MediaQuery.of(context).size;

    if (SizeConfig(size).crossAxisCount <= 5) {
      Library.globalData["sideBarIsOpen"] = false;
      sideBarIsOpen = false;
    } else {
      Library.globalData["sideBarIsOpen"] = true;
      sideBarIsOpen = true;
    }

    return SafeArea(
      bottom: false,
      child: FadeInLeft(
        parentObject: widget.parentObject,
        size: 300,
        child: Listener(
          onPointerDown: (e) {
            widget.parentObject.closeThemeMenu();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorLight,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  width: SizeConfig(size).crossAxisCount < 2
                      ? 0
                      : !sideBarIsOpen
                          ? 70
                          : 256,
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
                                              width: sideBarIsOpen ? 200 : 50,
                                              height: sideBarIsOpen ? 150 : 50,
                                              child: ImageLoader(
                                                imageUrl: Provider.of<Notifier>(context).user.avatar.toString(),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white.withOpacity(0.7),
                                                    width: sideBarIsOpen ? 7 : 1,
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
                                            AnimatedContainer(
                                              duration: Duration(milliseconds: 500),
                                              curve: Curves.easeInOut,
                                              width: sideBarIsOpen ? 200 : 50,
                                              height: sideBarIsOpen ? 150 : 50,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/gradient.jpg"),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors.white.withOpacity(0.7),
                                                    width: sideBarIsOpen ? 7 : 1,
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
                                          SizedBox(
                                            height: sideBarIsOpen ? 10 : 0,
                                          ),
                                          if (sideBarIsOpen)
                                            Center(
                                              child: Container(
                                                child: Consumer<Notifier>(
                                                  builder: (context, x, child) => Text(
                                                    x.user.userName,
                                                    style: Library.textStyle.copyWith(
                                                        fontWeight: FontWeight.w900, color: Library.darkTheme ? Library.darkThemeData().indicatorColor : Library.lightThemeData().indicatorColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (sideBarIsOpen)
                                            Center(
                                              child: Container(
                                                child: Consumer<Notifier>(
                                                  builder: (context, x, child) => Text(
                                                    x.user.lastName,
                                                    style: Library.textStyle.copyWith(color: Library.darkTheme ? Library.darkThemeData().indicatorColor : Library.lightThemeData().indicatorColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: sideBarIsOpen ? 20 : 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    for (int x = 0; x < menuItems.length; x++)
                                      MenuItems(
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
                        child: MenuItems(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  final String itemText;
  final IconData itemIcon;
  final int selected;
  final int position;
  final dynamic menu;
  final Function? onClick;

  const MenuItems({
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
              child: Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: !menu.sideBarIsOpen ? MainAxisAlignment.center : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        itemIcon,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                    if (menu.sideBarIsOpen)
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
                child: Container(
                  color: selected == position ? Theme.of(context).primaryColorDark : null,
                  child: Row(
                    mainAxisAlignment: !menu.sideBarIsOpen ? MainAxisAlignment.center : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Icon(
                          itemIcon,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      if (menu.sideBarIsOpen)
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
