import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/profile_service.dart';
import 'package:crowds/services/profile_view_model.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/drop_down_view_model.dart';
import 'package:crowds/widgets/dropdown_button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  ProfileViewModel _profileViewModel = ProfileViewModel();
  final _fullNameController = TextEditingController();
  final _venmoController = TextEditingController();
  final states = ProfileService.states
      .map((e) => DropDownViewModel(value: e, title: e))
      .toList();

  Future<void> _create(BuildContext context) async {
    String? errorMessage;
    if (_fullNameController.text.isEmpty) {
      errorMessage = "Please enter your full name.";
    } else if (_profileViewModel.stateInUS == null) {
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
      ProfileService().createUser(
        fullName: _fullNameController.text,
        stateInUS: _profileViewModel.stateInUS ?? '',
        venmoUserName: _venmoController.text,
      );

      context.pushReplacementNamed('ProfileCreatedPage');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    DropDownViewModel? getSelectedDropDownItem() {
      try {
        if (_profileViewModel.stateInUS != null) {
          return states
              .where((element) => element.value == _profileViewModel.stateInUS)
              .first;
        }
      } catch (e) {}
      return null;
    }

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
          DropDownWidget(
            title: "State in US",
            value: getSelectedDropDownItem(),
            items: states,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _profileViewModel.stateInUS = value.title;
                });
              }
            },
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
