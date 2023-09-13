import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  void _forgotPassword(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Reset password",
      icon: Icons.lock_reset_outlined,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: "Email",
            hintText: "Email",
            controller: TextEditingController(),
          ),
          SizedBox(height: 24),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Send reset password email",
              onPressed: () async => _forgotPassword(context),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
