import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/dialog_service.dart';
import 'package:crowds/services/profile_service.dart';
import 'package:crowds/services/profile_view_model.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/drop_down_view_model.dart';
import 'package:crowds/widgets/dropdown_button_widget.dart';
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
  ProfileViewModel? _profileViewModel;
  final _fullNameController = TextEditingController();
  final _venmoController = TextEditingController();
  final states = ProfileService.states
      .map((e) => DropDownViewModel(value: e, title: e))
      .toList();

  Future<void> _signOut(BuildContext context) async {
    DialogService.show(
      context: context,
      title: "Sign out",
      description: "Sign out of the application?",
      onYes: () {
        Future.delayed(Duration(milliseconds: 300), () async {
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
    } else if (_profileViewModel?.stateInUS == null) {
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
      ProfileService().updateUser(
        _profileViewModel,
        fullName: _fullNameController.text,
        stateInUS: _profileViewModel?.stateInUS ?? '',
        venmoUserName: _venmoController.text,
      );
      context.pop();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _profileViewModel = await ProfileService().getUser();
    _fullNameController.text = _profileViewModel?.fullName ?? '';
    _venmoController.text = _profileViewModel?.venmoUserName ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    DropDownViewModel? getSelectedDropDownItem() {
      try {
        if (_profileViewModel?.stateInUS != null) {
          return states
              .where((element) => element.value == _profileViewModel?.stateInUS)
              .first;
        }
      } catch (e) {}
      return null;
    }

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
          DropDownWidget(
            title: "State in US",
            value: getSelectedDropDownItem(),
            items: states,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _profileViewModel?.stateInUS = value.title;
                });
              }
            },
          ),
          SizedBox(height: 24),
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
