import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controllerUserName = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerPasswordConfirm = TextEditingController();

  Future<void> _register(BuildContext context) async {
    String? errorMessage;
    if (_controllerUserName.text.isEmpty) {
      errorMessage = "Please enter your email address.";
    } else if (_controllerPassword.text.isEmpty) {
      errorMessage = "Please enter your password.";
    } else if (_controllerPasswordConfirm.text.isEmpty) {
      errorMessage = "Please enter your password confirm.";
    } else if (_controllerPassword.text != _controllerPasswordConfirm.text) {
      errorMessage =
          "Your passwords do not match. Please make sure that you enter the same password in both fields.";
    }

    if (errorMessage != null) {
      SnackBarService.show(
        context: context,
        title: errorMessage,
        type: SnackBarType.error,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerUserName.text,
        password: _controllerPassword.text,
      );

      context.pushReplacementNamed('createProfilePage');
    } on FirebaseAuthException catch (e) {
      SnackBarService.show(
        context: context,
        title: e.message ?? "register problem.",
        type: SnackBarType.error,
      );
    } catch (e) {
      print(e);
    }
  }

  void _login(BuildContext context) {
    context.pushReplacementNamed('loginPage');
  }

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
            controller: _controllerUserName,
          ),
          SizedBox(height: 24),
          TextFormFieldWidget(
            labelText: "Password",
            hintText: "Password",
            obscureText: true,
            controller: _controllerPassword,
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Confirm password",
            hintText: "Confirm password",
            obscureText: true,
            controller: _controllerPasswordConfirm,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Register",
              onPressed: () async => await _register(context),
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
