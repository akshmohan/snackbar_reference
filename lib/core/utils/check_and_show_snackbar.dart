import 'package:flutter/material.dart';
import 'package:machine_test_practice/core/utils/show_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInSuccessSnackbar(BuildContext context, String content) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isSnackbarShown = prefs.getBool('isSnackbarShown') ?? false;

  if (!isSnackbarShown) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSnackbar(context, content);
    });

    prefs.setBool('isSnackbarShown', true);
  }
}
