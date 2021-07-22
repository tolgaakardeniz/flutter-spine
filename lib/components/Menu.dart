/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/


/*

import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<String> menuItems = Library.globalData["menuItems"];
  final List<IconData> menuIcons = Library.globalData["menuIcons"];
  final List<Function> menuOnClick = Library.globalData["menuOnClick"];
  int selectedMenuItem = Library.globalData["selectedMenuItem"];

  bool sideBarIsOpen = false;

  double yOffset = 0;
  double xOffset = 60;
  double pageScale = 1;

  void sideBarState() {
    setState(() {
      xOffset = sideBarIsOpen ? 270 : 60;
      yOffset = sideBarIsOpen ? 100 : 0;
      pageScale = sideBarIsOpen ? 0.7 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: GestureDetector(
                onHorizontalDragUpdate: (e) {
                  if (e.delta.dx > 0) {
                    setState(() {
                      sideBarIsOpen = true;
                      sideBarState();
                    });
                  } else {
                    setState(() {
                      sideBarIsOpen = false;
                      sideBarState();
                    });
                  }
                },
                child: Container(
                  width: 230,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    */
/*mainAxisSize: MainAxisSize.max,*//*

                    children: [
                      Expanded(
                        flex: 10,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            verticalDirection: VerticalDirection.down,
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: sideBarIsOpen? 250 : 1000),
                                    curve: Curves.easeInOut,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                          width: sideBarIsOpen ? 200 : 40,
                                          height: sideBarIsOpen ? 150 : 40,
                                          margin:
                                          EdgeInsets.all(sideBarIsOpen ? 20 : 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.7),
                                              width: sideBarIsOpen ? 7 : 1,
                                            ),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: new NetworkImage(
                                                  "https://pbs.twimg.com/profile_images/1392587441001963522/aFxZfYko_400x400.jpg"),
                                              fit: BoxFit.contain,
                                            ),
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
                                        if (sideBarIsOpen)
                                          Center(
                                            child: Container(
                                              child: Text(
                                                "Armegedon",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    color: Theme.of(context).indicatorColor,),
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          height: sideBarIsOpen ? 30 : 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: false,
                                  itemCount: menuItems.length,
                                  itemBuilder: (context, x) => MenuItems(
                                    itemIcon: menuIcons[x],
                                    itemText: menuItems[x],
                                    position: x,
                                    selected: Library.globalData["selectedMenuItem"],
                                    menu: this,
                                    onClick: menuOnClick[x],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            */
/*sideBarIsOpen = false;*//*

                            Library.globalData["selectedMenuItem"] = selectedMenuItem = menuItems.length;
                            sideBarState();
                          },
                          child: MenuItems(
                            itemIcon: Icons.logout,
                            itemText: AppLocalizations.getTranslate("0013"),
                            position: menuItems.length,
                            selected: Library.globalData["selectedMenuItem"],
                            menu: this,
                            onClick: menuOnClick[menuItems.length],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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

  const MenuItems(
      {Key? key,
        required this.itemText,
        required this.itemIcon,
        required this.selected,
        required this.position,
        required this.menu,
        this.onClick,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HoverWidget(
      onHover: (event) {
        menu.sideBarState();
      },
      hoverChild: InkWell(
        onTap: () {
          Library.globalData["selectedMenuItem"] = menu.selectedMenuItem = position;
          menu.sideBarState();

          print(onClick.toString());

          if (onClick != null) {
            onClick!();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                  left: position == selected
                      ? menu.sideBarIsOpen == false
                      ? 10
                      : 0
                      : 0),
              color: Color(0xFF333333),
              child: Row(
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
                      itemText,
                      style: TextStyle(
                          color: Theme.of(context).indicatorColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Library.globalData["selectedMenuItem"] = menu.selectedMenuItem = position;
          menu.sideBarState();
          print(onClick.toString());
          if (onClick != null) {
            onClick!();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(left: 5, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: EdgeInsets.only(
                  left: position == selected
                      ? menu.sideBarIsOpen == false
                      ? 10
                      : 0
                      : 0),
              color:
              selected == position ? Color(0xFF333333) : Colors.transparent,
              child: Row(
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
                      itemText,
                      style: TextStyle(
                          color: Theme.of(context).indicatorColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
