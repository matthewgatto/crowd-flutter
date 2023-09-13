import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _forgotPassword(BuildContext context) {}

  void _register(BuildContext context) {}

  void _login(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Login",
      icon: Icons.account_circle,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: "Email",
            hintText: "Email",
            controller: TextEditingController(),
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Password",
            hintText: "Password",
            controller: TextEditingController(),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Login",
              onPressed: () => _login(context),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have account!  "),
              TextButton(
                child: Text("Register"),
                onPressed: () => _register(context),
              ),
            ],
          ),
          SizedBox(height: 8),
          TextButton(
            child: Text("Forgot password"),
            onPressed: () => _forgotPassword(context),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
