/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({Key? key}) : super(key: key);

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState
    extends State<CollapsingNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(itemBuilder: (context, counter) {
/*          return CollapsingList(
            title: navigationItems[counter].title,
            icon: navigationItems[counter].icon,
          );*/
        return Text("dd");
        }),
      ],
    );
  }
}
