import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerUserName = TextEditingController();
  final _controllerPassword = TextEditingController();

  void _forgotPassword(BuildContext context) {
    context.pushReplacementNamed('forgotPasswordPage');
  }

  void _register(BuildContext context) {
    context.pushReplacementNamed('registerPage');
  }

  Future<void> _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerUserName.text,
        password: _controllerPassword.text,
      );
      context.pushReplacementNamed('StartPage');
    } on FirebaseAuthException catch (e) {
      SnackBarService.show(
        context: context,
        title: e.message ?? "login problem.",
        type: SnackBarType.error,
      );
    } catch (e) {
      print(e);
    }
  }

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
            controller: _controllerUserName,
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Password",
            hintText: "Password",
            obscureText: true,
            controller: _controllerPassword,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Login",
              onPressed: () async => await _login(context),
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
