import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  void _register(BuildContext context) {}
  
  void _login(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Register",
      icon: Icons.supervised_user_circle,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: "Email",
            hintText: "Email",
            controller: TextEditingController(),
          ),
          SizedBox(height: 24),
          TextFormFieldWidget(
            labelText: "Password",
            hintText: "Password",
            controller: TextEditingController(),
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Confirm password",
            hintText: "Confirm password",
            controller: TextEditingController(),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Register",
              onPressed: () async => _register(context),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have account!  "),
              TextButton(
                child: Text("Login"),
                onPressed: () => _login(context),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
