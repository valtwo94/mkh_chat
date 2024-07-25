import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mkh_chat/constants/routes.dart';

class VerificationProvider with ChangeNotifier {
  final PageController pageController = PageController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController verificationNumberController = TextEditingController();
  late CountryCode selectedCode;

  VerificationProvider(Locale locale) {
    selectedCode =
        CountryCode.fromCountryCode(_getCountryCodeFromLocale(locale));
  }

  void initialize() {
    pageController.jumpToPage(0);
    phoneNumberController.clear();
    verificationNumberController.clear();
  }

  String _getCountryCodeFromLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'US';
      case 'ko':
        return 'KR';
      default:
        return 'US';
    }
  }

  void onChangeCountryCode (CountryCode code){
    selectedCode = code;
    notifyListeners();
  }

  Future<void> sendVerificationCode() async {
    pageController.jumpToPage(1);
    notifyListeners();
  }

  void onKeyPressed(String v) {
    final currentStep = pageController.page!.toInt() + 1;
    switch (v) {
      case "back":
        if (currentStep == 1) {
          if (phoneNumberController.text.isNotEmpty) {
            phoneNumberController.text = phoneNumberController.text
                .substring(0, phoneNumberController.text.length - 1);
          }
        } else {
          if (verificationNumberController.text.isNotEmpty) {
            verificationNumberController.text = verificationNumberController
                .text
                .substring(0, verificationNumberController.text.length - 1);
          }
        }
        break;
      default:
        if (currentStep == 1) {
          phoneNumberController.text += v;
        } else {
          if (verificationNumberController.text.length < 4) {
            verificationNumberController.text += v;
          }
        }
    }
    notifyListeners();
  }

  void onBackButtonLongPressed() {
    phoneNumberController.clear();
  }

  //TODO:
  Future<void> onCompleteVerificationCode(String verificationCode, BuildContext context) async {
    Navigator.pushReplacementNamed(context, Routes.profileAccount);
  }



  @override
  void dispose() {
    phoneNumberController.dispose();
    verificationNumberController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
