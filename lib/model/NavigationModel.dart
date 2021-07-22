/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class NavigationModel {
  String? title;
  IconData? icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Deneme", icon: Icons.light),
  NavigationModel(title: "Deneme", icon: Icons.light),
  NavigationModel(title: "Deneme", icon: Icons.light),
  NavigationModel(title: "Deneme", icon: Icons.light),
  NavigationModel(title: "Deneme", icon: Icons.light),
  NavigationModel(title: "Deneme", icon: Icons.light),
];