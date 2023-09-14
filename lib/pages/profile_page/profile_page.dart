import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/dialog_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../services/snack_bar_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _fullNameController = TextEditingController();
  final _stateController = TextEditingController();
  final _venmoController = TextEditingController();

  Future<void> _signOut(BuildContext context) async {
    DialogService.show(
      context: context,
      title: "Sign out",
      description: "Sign out of the application?",
      onYes: () {
        Future.delayed(Duration(milliseconds: 300),() async {
          await FirebaseAuth.instance.signOut();
          context.pushReplacementNamed("StartPage");
        });
      },
      onNo: () {},
    );
  }

  Future<void> _cancel(BuildContext context) async {
    context.pop();
  }

  Future<void> _create(BuildContext context) async {
    String? errorMessage;
    if (_fullNameController.text.isEmpty) {
      errorMessage = "Please enter your full name.";
    } else if (_stateController.text.isEmpty) {
      errorMessage = "Please enter state.";
    } else if (_venmoController.text.isEmpty) {
      errorMessage = "Please enter your venmo user name.";
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
      var user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('userInformation')
          .doc(user?.uid)
          .set({
        "fullName": _fullNameController.text,
        "stateInUS": _stateController.text,
        "venmoUserName": _venmoController.text,
      });

      context.pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profile ",
      icon: Icons.account_circle,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            labelText: "Full name",
            hintText: "Full name",
            controller: _fullNameController,
          ),
          SizedBox(height: 24),
          TextFormFieldWidget(
            labelText: "State in US",
            hintText: "State in US",
            controller: _stateController,
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Venmo user name",
            hintText: "Venmo user name",
            controller: _venmoController,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "save",
              onPressed: () async => _create(context),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "cancel",
              onPressed: () async => _cancel(context),
            ),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () => _signOut(context),
            child: Text("Sign out"),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
