import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String? appBarTitle;
  final String? title;
  final Widget? body;
  final IconData? icon;

  const BaseScaffold({
    this.body,
    this.appBarTitle,
    this.title,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var mainColor = FlutterFlowTheme.of(context).splash;
    var iconSize = 80.0;
    var padding = 16.0;
    Widget getBody() {
      if (appBarTitle != null) {
        return body ?? SizedBox();
      }
      return SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Card(
                margin: EdgeInsets.only(
                  left: padding,
                  right: padding,
                  top: iconSize / 2,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: title != null,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: iconSize / 2,
                            bottom: 30,
                            left: 30,
                            right: 30,
                          ),
                          child: Column(
                            children: [
                              AutoSizeText(
                                title ?? '',
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body ?? SizedBox(),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: icon != null,
                child: Hero(
                  tag: "profileButton",
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    child: Icon(
                      icon,
                      color: mainColor,
                      size: iconSize,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBarTitle != null
          ? AppBar(
              backgroundColor: mainColor,
              title: Text(appBarTitle ?? ""),
            )
          : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/page_background@2x.png',
            ).image,
          ),
        ),
        child: getBody(),
      ),
    );
  }
}
