// 라우트 static class 처리

import 'package:flutter/material.dart';

class Routes {
  static const String walkthrough =  '/walkthrough';
  static const String verification = '/verification';
  static const String profileAccount = '/profile/account';
  static const String main = '/main';



  static Route createRoute(Widget page) {

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}