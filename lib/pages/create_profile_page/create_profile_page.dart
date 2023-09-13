import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class CreateProfilePage extends StatelessWidget {
  const CreateProfilePage({super.key});

  void _create(BuildContext context) {}
  

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
            controller: TextEditingController(),
          ),
          SizedBox(height: 24),
          TextFormFieldWidget(
            labelText: "State in US",
            hintText: "State in US",
            controller: TextEditingController(),
          ),
          SizedBox(height: 16),
          TextFormFieldWidget(
            labelText: "Venmo user name",
            hintText: "Venmo user name",
            controller: TextEditingController(),
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
