/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/animations/FadeInUp.dart';
import 'package:spine/constants.dart';
import 'package:spine/localizations.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class SettingsMenu extends StatefulWidget {
  final int position;
  final dynamic parentObject;
  const SettingsMenu({Key? key, required this.position, required this.parentObject}) : super(key: key);

  @override
  _SettingsMenuState createState() => _SettingsMenuState();
}

class _SettingsMenuState extends State<SettingsMenu>
    with SingleTickerProviderStateMixin {


  final List<IconData> settingsMenuIcons = [
    Icons.person,
    Icons.vpn_key,
    Icons.assignment_ind,
    Icons.add_location,
    Icons.food_bank_outlined,
    Icons.notifications_none,
    Icons.block,
    Icons.security,
  ];

  final List<String> settingsMenuItems = [
    AppLocalizations.getTranslate("0029"),
    AppLocalizations.getTranslate("0030"),
    AppLocalizations.getTranslate("0031"),
    AppLocalizations.getTranslate("0032"),
    AppLocalizations.getTranslate("0033"),
    AppLocalizations.getTranslate("0034"),
    AppLocalizations.getTranslate("0035"),
    AppLocalizations.getTranslate("0036"),
  ];

  int selectedMenuItem = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refreshState() {
    setState(() {
      /*Library.debugPrint("SettingsMenu widget setState is was now run");*/
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: maxSize(size.width, 1440),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 100,
            color: Theme.of(context).buttonColor,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              children: [
                for (int x = 0; x < settingsMenuItems.length; x++)
                  SettingsMenuItems(
                    itemIcon: settingsMenuIcons[x],
                    itemText: settingsMenuItems[x],
                    position: x,
                    selected: selectedMenuItem,
                    menu: this,
/*                    onClick: settingsMenuOnClick[x],*/
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsMenuItems extends StatelessWidget {
  final String itemText;
  final IconData itemIcon;
  final int selected;
  final int position;
  final dynamic menu;
  final Function? onClick;

  const SettingsMenuItems({
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
        //menu.refreshState();
      },
      hoverChild: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                menu.widget.parentObject.selectedMenuItem = menu.selectedMenuItem = position;
                menu.refreshState();
                menu.widget.parentObject.refreshState();

                if (onClick != null) {
                  onClick!();
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          itemIcon,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      Text(
                        itemText,
                        style:
                        TextStyle(color: Theme.of(context).indicatorColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: FadeInUp(
          startDuration: Duration(milliseconds: (50 * position)),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  menu.widget.parentObject.selectedMenuItem = menu.selectedMenuItem = position;
                  menu.refreshState();
                  menu.widget.parentObject.refreshState();

                  if (onClick != null) {
                    onClick!();
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  color: selected == position
                      ? Theme.of(context).primaryColorDark
                      : null,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            itemIcon,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        Text(
                          itemText,
                          style: TextStyle(
                              color: Theme.of(context).indicatorColor),
                        ),
                      ],
                    ),
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
