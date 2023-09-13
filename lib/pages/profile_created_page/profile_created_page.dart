import 'package:crowds/widgets/base_scaffold.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileCreatedPage extends StatelessWidget {
  const ProfileCreatedPage({super.key});

  void _goToApp(BuildContext context) {
    context.pushReplacementNamed('StartPage');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profile created",
      icon: Icons.check_circle,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 20,
            ),
            child: Text(
              "All your content in one place, it’s time to start exploring.",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ButtonWidget(
              title: "Go to the Crowds App",
              onPressed: () async => _goToApp(context),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
