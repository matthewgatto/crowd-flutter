import 'package:crowds/widgets/button_widget.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'answering_question_successfully_model.dart';
export 'answering_question_successfully_model.dart';

class AnsweringQuestionSuccessfullyWidget extends StatefulWidget {
  const AnsweringQuestionSuccessfullyWidget({
    Key? key,
    this.gameRef,
  }) : super(key: key);

  final DocumentReference? gameRef;

  @override
  _AnsweringQuestionSuccessfullyWidgetState createState() =>
      _AnsweringQuestionSuccessfullyWidgetState();
}

class _AnsweringQuestionSuccessfullyWidgetState
    extends State<AnsweringQuestionSuccessfullyWidget> {
  late AnsweringQuestionSuccessfullyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnsweringQuestionSuccessfullyModel());
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
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width * 0.07,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Text(
                        'Awesome!',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).displaySmall,
                      ),
                      SizedBox(height: 26),
                      Text(
                        'You have successfully answered a question',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Roboto',
                              fontSize: 19.0,
                            ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).splash,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Text(
                          'Your rewards will be available for you in 1-3 business days after the question is closed. ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
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
  }
}
