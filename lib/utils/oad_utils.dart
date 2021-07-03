import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class OADUtils {
  static showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Get.theme.errorColor,
      backgroundColor: Colors.black87,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }

  static showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: kSuccessColor,
      backgroundColor: Colors.black87,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}
