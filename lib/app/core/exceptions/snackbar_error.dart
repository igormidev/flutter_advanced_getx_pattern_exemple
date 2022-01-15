import 'package:flutter/material.dart';
import 'package:flutter_good_practices/app/core/utils/extensions.dart';
import 'package:get/get.dart';

showError({required String error, required String details}) {
  Get.snackbar(error, 'Detalhes: ' + details,
      backgroundColor: Colors.red.withOpacity(0.5),
      margin: EdgeInsets.symmetric(vertical: 1.4.hp, horizontal: 3.0.wp));
}

showMessage({required String error, required String details}) {
  Get.snackbar(error, details,
      margin: EdgeInsets.symmetric(vertical: 1.4.hp, horizontal: 3.0.wp));
}
