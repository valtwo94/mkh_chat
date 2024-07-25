import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mkh_chat/widgets/buttons/primary.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mkh_chat/widgets/keyboards/number.dart';

import '../constants/routes.dart';

class WalkthroughPage extends StatelessWidget {
  const WalkthroughPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/walkthrough.png'),
            const SizedBox(height: 42,),
            SizedBox(
              width: MediaQuery.of(context).size.width/375*273,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.walkthroughMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const Flexible(child: SizedBox(height: 126,),),
            Text(AppLocalizations.of(context)!.termsAndPrivacy, style: Theme.of(context).textTheme.displaySmall,),
            const SizedBox(height: 18,),
            PrimaryButton(
              onPressed: ()=> Navigator.of(context).pushReplacementNamed(Routes.verification),
              label: AppLocalizations.of(context)!.startMessaging,
            ),

          ],
        ),
      ),
    );
  }
}