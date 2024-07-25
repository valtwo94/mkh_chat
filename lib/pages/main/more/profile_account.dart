import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mkh_chat/providers/profile_account.dart';
import 'package:mkh_chat/widgets/buttons/primary.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileAccountPage extends StatelessWidget {
  const ProfileAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .appBarTheme
              .backgroundColor,
          title: Text(AppLocalizations.of(context)!.yourProfile, style: Theme
              .of(context)
              .textTheme
              .labelLarge,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 47, left: 24, right: 24),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImagePicker(context),
                const SizedBox(height: 32,),
                TextFormField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  decoration: InputDecoration(
                      fillColor: Theme
                          .of(context)
                          .inputDecorationTheme
                          .fillColor,
                      filled: true,
                      enabledBorder: Theme
                          .of(context)
                          .inputDecorationTheme
                          .enabledBorder,
                      focusedBorder: Theme
                          .of(context)
                          .inputDecorationTheme
                          .enabledBorder,
                      hintStyle: Theme
                          .of(context)
                          .inputDecorationTheme
                          .hintStyle,
                      hintText: AppLocalizations.of(context)!.firstNamePlaceholder
                  ),
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  decoration: InputDecoration(
                      fillColor: Theme
                          .of(context)
                          .inputDecorationTheme
                          .fillColor,
                      filled: true,
                      enabledBorder: Theme
                          .of(context)
                          .inputDecorationTheme
                          .enabledBorder,
                      focusedBorder: Theme
                          .of(context)
                          .inputDecorationTheme
                          .enabledBorder,
                      hintStyle: Theme
                          .of(context)
                          .inputDecorationTheme
                          .hintStyle,
                      hintText: AppLocalizations.of(context)!.lastNamePlaceholder
                  ),
                ),
                const SizedBox(height: 68,),
                PrimaryButton(onPressed: () {}, label: AppLocalizations.of(context)!.save)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    bool hasFile = context
        .watch<ProfileAccountProvider>()
        .imageFile != null;
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          GestureDetector(
            onTap: context.read<ProfileAccountProvider>().selectImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Theme
                  .of(context)
                  .canvasColor,
              child: Center(
                child: context
                    .watch<ProfileAccountProvider>()
                    .imageFile != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    width: double.infinity,
                    height: double.infinity,
                    context
                        .watch<ProfileAccountProvider>()
                        .imageFile!, fit: BoxFit.cover,),
                ) : const Icon(Icons.person, size: 56,),
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            right: 5,
            child: GestureDetector(
              onTap: hasFile?
                  context.read<ProfileAccountProvider>().deleteImage
                  :context
                  .read<ProfileAccountProvider>()
                  .selectImage,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: hasFile ? Colors.red : Colors.black,
                child: Center(
                  child: Icon(
                    hasFile ? Icons.delete : Icons.add, color: Colors.white,
                    size: 16,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
