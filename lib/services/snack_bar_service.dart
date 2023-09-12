import 'package:flutter/material.dart';

class SnackBarService {
  static void show(BuildContext context,String title){
    var snackBar = SnackBar(
      content: Text(title),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}