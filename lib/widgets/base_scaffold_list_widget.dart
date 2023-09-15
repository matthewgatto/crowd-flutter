import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BaseScaffoldListWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? bottomWidget;
  final Widget? titleIcon;

  const BaseScaffoldListWidget({
    required this.child,
    required this.title,
    this.bottomWidget,
    this.titleIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/page_background@2x.png',
            ).image,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 36,
                      left: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => context.pop(),
                        ),
                        Expanded(
                          child: AutoSizeText(
                            title,
                            maxLines: 1,
                            style: FlutterFlowTheme.of(context).displaySmall,
                          ),
                        ),
                        titleIcon ?? SizedBox(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: child,
                    ),
                  ),
                  Visibility(
                    visible: bottomWidget != null,
                    child: bottomWidget ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
