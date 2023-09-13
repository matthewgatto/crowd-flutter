import 'package:crowds/widgets/button_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'create_question_successfully_model.dart';
export 'create_question_successfully_model.dart';

class CreateQuestionSuccessfullyWidget extends StatefulWidget {
  const CreateQuestionSuccessfullyWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.typeReceived,
  }) : super(key: key);

  final String? title;
  final String? time;
  final DocumentReference? typeReceived;

  @override
  _CreateQuestionSuccessfullyWidgetState createState() =>
      _CreateQuestionSuccessfullyWidgetState();
}

class _CreateQuestionSuccessfullyWidgetState
    extends State<CreateQuestionSuccessfullyWidget> {
  late CreateQuestionSuccessfullyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateQuestionSuccessfullyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionNewRecord>>(
      stream: queryQuestionNewRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F5F5),
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F5F5),
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
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                          Text(
                            'You have created a new question titled: ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).displaySmall,
                          ),
                          SizedBox(height: 16),
                          Text(
                            valueOrDefault<String>(
                              widget.title,
                              'default',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto',
                                  color: FlutterFlowTheme.of(context).splash,
                                  fontSize: 28.0,
                                ),
                          ),
                          SizedBox(height: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://media.giphy.com/media/6mEQOWSYJlnNCPuXNT/giphy.gif',
                              width: 150.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Your question will be answered in: ',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .displaySmall
                                .override(
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            widget.time ?? '',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Roboto',
                                  color: FlutterFlowTheme.of(context).splash,
                                  fontSize: 20.0,
                                ),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1.0,
                            color: FlutterFlowTheme.of(context).splash,
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 10.0),
                              child: Text(
                                'What\'s next? ',
                                textAlign: TextAlign.center,
                                style:
                                    FlutterFlowTheme.of(context).displaySmall,
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03),
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ButtonWidget(
                              title: 'Ask a question',
                              onPressed: () async {
                                context.pushReplacementNamed('CreateQuestion');
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 80,
                            child: ButtonWidget(
                              title: 'View list of questions to answer',
                              color: Colors.deepOrangeAccent,
                              onPressed: () async {
                                context.pushReplacementNamed('ListQuestions');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).cardColor,
                    ),
                    child: Icon(
                      Icons.check_circle,
                      size: MediaQuery.of(context).size.width * 0.15,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
