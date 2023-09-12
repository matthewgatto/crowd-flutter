import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/dialog_service.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'answering_question_model.dart';
export 'answering_question_model.dart';

class AnsweringQuestionWidget extends StatefulWidget {
  const AnsweringQuestionWidget({
    Key? key,
    required this.titleReceived,
    required this.questionReceived,
  }) : super(key: key);

  final String? titleReceived;
  final String? questionReceived;

  @override
  _AnsweringQuestionWidgetState createState() =>
      _AnsweringQuestionWidgetState();
}

class _AnsweringQuestionWidgetState extends State<AnsweringQuestionWidget> {
  late AnsweringQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnsweringQuestionModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<bool> _cancelQuestion(BuildContext context) async {
    if (_model.textController.text.isNotEmpty) {
      DialogService.show(
        title: "Warning",
        description: 'Current process will be lost.',
        description2: "Do you want to cancel the process?",
        context: context,
        onApprove: () => context.pushReplacementNamed('ListQuestions'),
        onCancel: () {},
      );
      return false;
    }
    context.pushReplacementNamed('ListQuestions');
    return false;
  }

  Future<void> _submitAnswer(BuildContext context) async{
    String? errorMessage;

    if (_model.textController.text.isEmpty) {
      errorMessage = "The Answer field is required.";
    }

    if (errorMessage != null) {
      SnackBarService.show(
        context: context,
        title: errorMessage,
        type: SnackBarType.error,
      );
      return;
    }

    await AnswerCompletedRecord.collection
        .doc()
        .set(createAnswerCompletedRecordData(
      answerText: valueOrDefault<String>(
        _model.textController.text,
        'NaN',
      ),
      questionTitle: valueOrDefault<String>(
        widget.titleReceived,
        'NaN',
      ),
      questionText: valueOrDefault<String>(
        widget.questionReceived,
        'NaN',
      ),
    ));

    context.pushReplacementNamed('AnsweringQuestionSuccessfully');
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
        return WillPopScope(
          onWillPop: () => _cancelQuestion(context),
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text('Answering...'),
              backgroundColor: FlutterFlowTheme.of(context).splash,
            ),
            backgroundColor: FlutterFlowTheme.of(context).customColor5,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  24.0,
                  10.0,
                  24.0,
                  10.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                0.0,
                                10.0,
                                0.0,
                                10.0,
                              ),
                              child: Text(
                                valueOrDefault<String>(
                                  widget.titleReceived,
                                  'Question Title',
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: FlutterFlowTheme.of(context).displaySmall,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                10.0,
                                10.0,
                                10.0,
                                10.0,
                              ),
                              child: Text(
                                widget.questionReceived!,
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextFormFieldWidget(
                              controller: _model.textController,
                              labelText: 'Answer',
                              hintText: 'Type Answer Here',
                              minLines: 10,
                              maxLines: 10,
                              validator:
                                  _model.textControllerValidator.asValidator(context),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Rewards Estimates',
                              style: FlutterFlowTheme.of(context).displaySmall,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'The price to ask this question is:',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            SizedBox(height: 16),
                            Text(
                              formatNumber(
                                random_data.randomDouble(0.5, 1.2),
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.automatic,
                                currency: '\$',
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xE339D261),
                                    fontSize: 36.0,
                                  ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'to',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            SizedBox(height: 8),
                            Text(
                              formatNumber(
                                random_data.randomDouble(1.9, 4.3),
                                formatType: FormatType.decimal,
                                decimalType: DecimalType.automatic,
                                currency: '\$',
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xE339D261),
                                    fontSize: 36.0,
                                  ),
                            ),
                            Text(
                              'for your submitted answer.',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ButtonWidget(
                        onPressed: () => _submitAnswer(context),
                        title: 'Submit',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
