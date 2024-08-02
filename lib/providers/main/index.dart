import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  MainProvider(Locale locale);

  void onTapBottomNavigationBarItem(int index) {
    currentIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
