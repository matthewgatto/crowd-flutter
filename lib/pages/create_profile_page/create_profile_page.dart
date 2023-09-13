import 'package:crowds/backend/backend.dart';
import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final _fullNameController = TextEditingController();
  final _stateController = TextEditingController();
  final _venmoController = TextEditingController();

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

      context.pushReplacementNamed('ProfileCreatedPage');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Create your profile ",
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
              title: "Create",
              onPressed: () async => _create(context),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
