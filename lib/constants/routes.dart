// 라우트 static class 처리

import 'package:flutter/material.dart';

class Routes {
  static const String walkthrough =  '/walkthrough';
  static const String verification = '/verification';
  static const String profileAccount = '/profile/account';
  static const String main = '/main';
  static const String chat = '/chat';
  static const String chatPicture = '/chat/picture';
  static const String chatCalendar = '/chat/calendar';
  static const String chatLoveLetter= '/chat/love_letter';
  static const String chatContents = '/chat/contents';
  static const String scheduleCreate = '/schedule/create';


  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  static Route createAnimationRoute(Widget page){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // 화면이 아래에서 위로 올라오는 애니메이션 시작 위치
        const end = Offset.zero;        // 화면의 끝 위치 (원래 위치)
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }
}