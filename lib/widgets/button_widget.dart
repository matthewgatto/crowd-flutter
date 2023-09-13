import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String title;
  final Future Function() onPressed;
  final Color? color;

  const ButtonWidget({
    required this.title,
    required this.onPressed,
    this.color,
    super.key,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool? _loading;

  Future<void> _localClick() async {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_loading == null) {
        setState(() {
          _loading = true;
        });
      }
    });
    try {
      await widget.onPressed.call();
    } catch (e) {}
    setState(() {
      _loading = false;
    });
  }

  @override
  void didUpdateWidget(covariant ButtonWidget oldWidget) {
    if (oldWidget != widget) {
      _loading = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                widget.color ?? FlutterFlowTheme.of(context).splash,
          ),
        ),
      ),
      child: ElevatedButton(
        onPressed: _localClick,
        child: _loading == true
            ? Center(child: CircularProgressIndicator())
            : AutoSizeText(
                widget.title,
                maxLines: 1,
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
