import 'package:crowds/enum/snack_bar_type.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static Color _getColor(SnackBarType type){
    switch(type){
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
        return Colors.green;
      case SnackBarType.message:
        return Colors.black;
    }
  }

  static void show({
    required BuildContext context,
    required String title,
    required SnackBarType type,
  }) {
    var snackBar = SnackBar(
      content: Text(title),
      backgroundColor: _getColor(type),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
