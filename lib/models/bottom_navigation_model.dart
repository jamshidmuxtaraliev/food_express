import 'package:flutter/cupertino.dart';

class BottomNavigationModel {

  final String title;
  final Icon icon;
  final Widget screen;
  bool active = false;

  BottomNavigationModel(this.title, this.icon, this.screen,
      {this.active = false});
}