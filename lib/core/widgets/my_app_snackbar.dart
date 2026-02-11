import 'package:flutter/material.dart';

class MyAppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool isSuccess = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: isSuccess ? Colors.green : Colors.red,
          duration: duration,
        ),
      );
  }
}
