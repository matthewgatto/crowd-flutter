import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/dialog_service.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'answering_question_model.dart';
export 'answering_question_model.dart';

class AnsweringQuestionWidget extends StatefulWidget {
  const AnsweringQuestionWidget({
    Key? key,
    required this.id,
    required this.titleReceived,
    required this.questionReceived,
    required this.questionPrice,
  }) : super(key: key);

  final String? id;
  final String? titleReceived;
  final String? questionReceived;
  final double? questionPrice;

  @override
  _AnsweringQuestionWidgetState createState() =>
      _AnsweringQuestionWidgetState();
}

class _AnsweringQuestionWidgetState extends State<AnsweringQuestionWidget> {
  late AnsweringQuestionModel _model;
  final creatorCut = 0.1;
  final questionPrice = 4.99;
  final priceGap = 0.25;
  get answerPrice => questionPrice - (questionPrice * creatorCut);
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

  Future<void> _submitAnswer(BuildContext context) async {
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
          answerBy: FirebaseAuth.instance.currentUser?.uid,
          createdAt: Timestamp.now(),
          modifiedAt: Timestamp.now(),
          questionId: valueOrDefault<String>(
            widget.id,
            'NaN',
          ),
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

  Future<int> _getRewardQuery() async {
    var usersThatAnswerQuestion = await AnswerCompletedRecord.collection
        .where("questionId", isEqualTo: widget.id)
        .get();
    var answerCount = usersThatAnswerQuestion.size;
    return answerCount.isInfinite || answerCount.isNaN ? 0 : answerCount;
  }

  @override
  Widget build(BuildContext context) {
    String _getStartRange(int userCount) {
      double userCut = answerPrice / userCount;
      userCut += userCut * priceGap;
      return "\$${userCut.toStringAsFixed(2)}";
    }

    String _getEndRange(int userCount) {
      double userCut = answerPrice / userCount;
      userCut -= userCut * priceGap;
      return "\$${userCut.toStringAsFixed(2)}";
    }

    return StreamBuilder<List<QuestionNewRecord>>(
      stream: queryQuestionNewRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
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
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  margin: EdgeInsets.all(16),
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
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () => context.pop(),
                                    ),
                                    Expanded(
                                      child: AutoSizeText(
                                        "Answering...",
                                        maxLines: 1,
                                        style: FlutterFlowTheme.of(context)
                                            .displaySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    valueOrDefault<String>(
                                      widget.titleReceived,
                                      'Question Title',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .displaySmall,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.questionReceived!,
                                    style:
                                        FlutterFlowTheme.of(context).bodyMedium,
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextFormFieldWidget(
                                  controller: _model.textController,
                                  labelText: '',
                                  hintText: 'Type Answer Here',
                                  minLines: 10,
                                  maxLines: 10,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Rewards Estimates',
                                  style:
                                      FlutterFlowTheme.of(context).displaySmall,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'The price to ask this question is:',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                ),
                                SizedBox(height: 16),
                                FutureBuilder(
                                  initialData: 0,
                                  future: _getRewardQuery(),
                                  builder: (context, snapshot) => Column(
                                    children: [
                                      Text(
                                        _getStartRange(snapshot.data ?? 0),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color: Color(0xE339D261),
                                              fontSize: 36.0,
                                            ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'to',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _getEndRange(snapshot.data ?? 0),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Roboto',
                                              color: Color(0xE339D261),
                                              fontSize: 36.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'for your submitted answer.',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
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
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
