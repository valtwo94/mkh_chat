import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAccountProvider with ChangeNotifier {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final picker = ImagePicker();
  File? imageFile;

  ProfileAccountProvider(Locale locale);

  Future<void> selectImage() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      imageFile = File(file.path);
      notifyListeners();
    }
  }

  void deleteImage() {
    imageFile = null;
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }
}
