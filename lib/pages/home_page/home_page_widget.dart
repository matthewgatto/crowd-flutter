import 'package:crowds/pages/list_questions/list_questions_widget.dart';
import 'package:crowds/widgets/button_widget.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(
              'assets/images/page_background@2x.png',
            ).image,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 6.0,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 54.0, 24.0, 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Crowds',
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Roboto',
                                        fontSize: 48.0,
                                      ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text("What would you like to do today?"),
                          SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ButtonWidget(
                              onPressed: () {
                                context.pushNamed('CreateQuestion');
                              },
                              title: 'Ask a question',
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ButtonWidget(
                              onPressed: () {
                                context.pushNamed('ListQuestions');
                              },
                              title: 'Answer a question',
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              context.pushNamed('aboutUs');
                            },
                            child: Text("How does Crowds work?"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
