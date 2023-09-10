import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String?>? validator;
  final int? minLines;
  final int? maxLines;

  const TextFormFieldWidget({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.minLines,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        isDense: true,
        labelText: labelText,
        hintText: 'insert question title here',
        filled: true,
      ),
      style: FlutterFlowTheme.of(context).bodyMedium,
      textAlign: TextAlign.start,
      minLines: minLines,
      maxLines: maxLines,
      validator: validator,
    );
  }
}
