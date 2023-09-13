import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _controllerUserName = TextEditingController();

  Future<void> _forgotPassword(BuildContext context) async {
    String? errorMessage;
    if (_controllerUserName.text.isEmpty) {
      errorMessage = "Please enter your email address.";
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
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _controllerUserName.text,
      );

      context.pushReplacementNamed('loginPage');
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
      title: "Reset password",
      icon: Icons.lock_reset_outlined,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: "Email",
            hintText: "Email",
            controller: _controllerUserName,
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
