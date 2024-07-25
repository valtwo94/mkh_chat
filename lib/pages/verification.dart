import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:mkh_chat/constants/options.dart';
import 'package:mkh_chat/providers/verification.dart';
import 'package:mkh_chat/widgets/buttons/primary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../widgets/keyboards/number.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: context.read<VerificationProvider>().pageController,
              children: [
                _buildStep1Page(context, const ValueKey('step1')),
                _buildStep2Page(context, const ValueKey('step2'))
              ],
            ),
          ),
          Expanded(
            child: NumberKeyboard(
              onKeyPressed: (v) =>
                  context.read<VerificationProvider>().onKeyPressed(v),
              onKeyLongPressed:
                  context.read<VerificationProvider>().onBackButtonLongPressed,
            ),
          )
        ],
      ),
    );
  }

  Padding _buildStep2Page(BuildContext context, Key key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.verificationStep2Title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "${AppLocalizations.of(context)!.verificationStep2Subtitle}\n${context.read<VerificationProvider>().selectedCode} ${context.watch<VerificationProvider>().phoneNumberController.text}",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 48,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: PinCodeTextField(
              controller: context
                  .read<VerificationProvider>()
                  .verificationNumberController,
              appContext: context,
              length: 4,
              readOnly: true,
              onCompleted: (v) => context
                  .read<VerificationProvider>()
                  .onCompleteVerificationCode(v, context),
              textStyle: Theme.of(context).textTheme.headlineLarge,
              hintCharacter: "●",
              hintStyle: TextStyle(
                  color: Theme.of(context).inputDecorationTheme.fillColor),
              cursorColor: Colors.transparent,
              cursorWidth: 0,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                  inactiveColor: Colors.transparent,
                  activeColor: Colors.transparent),
            ),
          ),
          const Flexible(
              child: SizedBox(
            height: 77,
          )),
          TextButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.resendCode,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
    );
  }

  Padding _buildStep1Page(BuildContext context, Key key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.verificationStep1Title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context)!.verificationStep1Subtitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 48,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).inputDecorationTheme.fillColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: CountryCodePicker(
                  onChanged: (code) => context
                      .read<VerificationProvider>()
                      .onChangeCountryCode(code),
                  showCountryOnly: false,
                  hideSearch: true,
                  searchDecoration: InputDecoration(
                      fillColor:
                          Theme.of(context).inputDecorationTheme.fillColor,
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle),
                  countryFilter: AppOptions.countryCodes
                      .map<String>((e) => e['code']!)
                      .toList(),
                  initialSelection: AppLocalizations.of(context)!.locale,
                  dialogSize: Size(MediaQuery.of(context).size.width - 24, 160),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  flex: 275,
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                        color: Theme.of(context).inputDecorationTheme.fillColor,
                        borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    child: TextFormField(
                      controller: context
                          .read<VerificationProvider>()
                          .phoneNumberController,
                      maxLength: 12,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                          counterText: '',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: AppLocalizations.of(context)!.phoneNumber,
                          enabled: false,
                          contentPadding: const EdgeInsets.only(bottom: 14)),
                    ),
                  ))
            ],
          ),
          const SizedBox(
            height: 81,
          ),
          PrimaryButton(
              onPressed:
                  context.read<VerificationProvider>().sendVerificationCode,
              label: AppLocalizations.of(context)!.sendCode),
        ],
      ),
    );
  }
}
