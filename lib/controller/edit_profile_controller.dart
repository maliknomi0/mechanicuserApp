import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/_services/storage.dart';
import 'package:repair/_services/uploads.dart';
import 'package:repair/global/SnackbarHelper.dart';
import 'package:repair/global/globle.dart';
import 'package:repair/loading.dart';

class EditProfileController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  String selectedGender = "Male"; // ✅ Default Gender Selection

  String profileImage = "defaultuser.png";

  final AppService _appService = AppService();
  File? selectedImage;
  void loadUserData() {
    var user = userSD["user"];

    if (user is Map) {
      nameController.text = user["name"]?.toString() ?? '';
      emailController.text = user["email"]?.toString() ?? '';
      phoneController.text = user["phone"]?.toString() ?? '';
      addresscontroller.text = user["address"]?.toString() ?? '';
      profileImage = user["profileImage"]?.toString() ?? "defaultuser.png";

      String gender = user["gender"]?.toString() ?? "Male";
      if (["Male", "Female", "Other"].contains(gender)) {
        selectedGender = gender;
      } else {
        selectedGender = "Male";
      }
    } else {
      print(
          "❌ ERROR: userSD['user'] is not a Map! Actual type: ${user.runtimeType}");
    }
  }

  // ✅ Pick Image from Gallery
  Future<void> pickImage(
      BuildContext context, Function setStateCallback) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setStateCallback(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> updateProfile(
      BuildContext context, Function setStateCallback) async {
    String uploadedImageUrl = profileImage;

    try {
      showLoader(context, "Updating Profile...");
      if (selectedImage != null) {
        uploadedImageUrl =
            (await doUploadImage(selectedImage!)) ?? profileImage;
      }
      Map<String, dynamic> data = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "profileImage": uploadedImageUrl,
        "phone": phoneController.text.trim(),
        "address": addresscontroller.text.trim(),
        "gender": selectedGender
      };

      final response = await _appService.updateUserProfile(data);

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      if (response['success']) {
        userSD = response["data"];
        if (response["data"] != null && response["data"]['token'] != null) {
          await Storage.setToken(response['data']['token']);
        } else {
          print("⚠️ No token found in response");
        }

        await Storage.setLogin(response['user']);

        SnackbarHelper.showSuccess(context, "Profile Updated Successfully");
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      SnackbarHelper.showError(
          context, "Failed to update profile. Please try again.");
    }
  }

  // ✅ Delete Account Functionality
  void deleteAccount(BuildContext context) {
    SnackbarHelper.showError(
        context, "Delete account functionality not implemented yet.");
  }
}
