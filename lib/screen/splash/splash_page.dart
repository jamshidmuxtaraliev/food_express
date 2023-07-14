import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_express/utils/app_colors.dart';
import 'package:food_express/utils/pref_utils.dart';

import '../../generated/assets.dart';
import '../../utils/utils.dart';
import '../auth_login/login_page.dart';
import '../main/main_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => (PrefUtils.getToken() == "") ? LoginPage() : MainScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: backgroundGradiet()),
      child: Center(
        child: Image.asset(
          Assets.imagesLogo3,
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
