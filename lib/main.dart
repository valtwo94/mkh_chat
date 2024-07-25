import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mkh_chat/constants/colors.dart';
import 'package:mkh_chat/constants/fonts.dart';
import 'package:mkh_chat/pages/main/more/profile_account.dart';
import 'package:mkh_chat/pages/verification.dart';
import 'package:mkh_chat/pages/walkthrough.dart';
import 'package:mkh_chat/providers/profile_account.dart';
import 'package:mkh_chat/providers/verification.dart';
import 'package:provider/provider.dart';
import 'constants/routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MKH_CHAT',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // 영어
        Locale('ko', 'KR'), // 한국어
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        canvasColor: AppColors.keyboardLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        textTheme: TextTheme(
          headlineLarge: Fonts.heading1,
          headlineMedium: Fonts.heading2,
          labelLarge: Fonts.subHeading1,
          labelMedium: Fonts.subHeading2,
          displayMedium: Fonts.body1,
          displaySmall: Fonts.body2,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.textFieldLight,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(4),
            ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.disabledLight
          )
        ),

      ),
      darkTheme: ThemeData(
          primaryColor: AppColors.primaryDark,
          scaffoldBackgroundColor: AppColors.backgroundLight),
      initialRoute: Routes.profileAccount,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.walkthrough:
            return  Routes.createRoute(const WalkthroughPage());
          case Routes.verification:
            return  Routes.createRoute(const VerificationPage());
          case Routes.profileAccount:
            return Routes.createRoute(const ProfileAccountPage());
          default:
            return null;
        }
      },
      builder: (context, child) {
        final locale = Localizations.localeOf(context);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VerificationProvider(locale)),
            ChangeNotifierProvider(create: (_) => ProfileAccountProvider(locale))
          ],
          child: child,
        );
      },
    );
  }
}
