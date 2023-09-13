import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:crowds/flutter_flow/nav/nav.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var style = Theme.of(context).textTheme.titleMedium;
    var mainStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        );

    Widget section({required String title, required String value}) {
      return Card(
        child: Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: double.infinity),
              Text(title, style: style),
              SizedBox(height: 8),
              Text(value, style: mainStyle),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).splash,
        title: Text("About us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Text("You get paid to answer questions. 🤩", style: mainStyle),
            SizedBox(height: 25),
            section(
              title: "Where does the money come from?",
              value: "People who pay to ask questions. 🤓",
            ),
            section(
              title: "Why are they paying to see my answers?",
              value:
                  "They get the wisdom of crowds. Think of it of it as the easiest, quickest, and cheapest way for a curious person to get an answer they have been looking for.  🧐",
            ),
            section(
              title: "Don't we have computers for this kind of thing?",
              value:
                  "Computers are good for historical answers. However, for any questions that involve the future, prediction, or opinions, humans like yourself are the best source to ask.  🤯",
            ),
            SizedBox(height: 25),
            Text(
              "Bet. I want to try Crowds.\nWhere do I start?",
              style: style,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25),
            Container(
              width: double.infinity,
              height: 50,
              child: ButtonWidget(
                title: "Ask and Answer Here",
                onPressed: () async {
                  context.pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
