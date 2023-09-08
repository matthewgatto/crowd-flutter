import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color? color;

  const ButtonWidget({
    required this.title,
    required this.onPressed,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? FlutterFlowTheme.of(context).splash,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ),
    );
  }
}
