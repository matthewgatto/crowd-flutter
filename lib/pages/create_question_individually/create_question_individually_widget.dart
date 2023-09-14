import 'package:auto_size_text/auto_size_text.dart';
import 'package:crowds/enum/question_length_type.dart';
import 'package:crowds/enum/snack_bar_type.dart';
import 'package:crowds/services/dialog_service.dart';
import 'package:crowds/services/snack_bar_service.dart';
import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'create_question_individually_model.dart';
export 'create_question_individually_model.dart';

class CreateQuestionIndividuallyWidget extends StatefulWidget {
  const CreateQuestionIndividuallyWidget({
    Key? key,
    required this.typeReceived,
  }) : super(key: key);

  final DocumentReference? typeReceived;

  @override
  _CreateQuestionIndividuallyWidgetState createState() =>
      _CreateQuestionIndividuallyWidgetState();
}

class _CreateQuestionIndividuallyWidgetState
    extends State<CreateQuestionIndividuallyWidget> {
  late CreateQuestionIndividuallyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateQuestionIndividuallyModel());

    _model.textController1 ??= TextEditingController();
    _model.textController2 ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<bool> _cancelQuestion(BuildContext context) async {
    if (_model.textController1.text.isNotEmpty ||
        _model.textController2.text.isNotEmpty ||
        _model.dropDownValue != null) {
      DialogService.show(
        title: "Warning",
        description: 'Current process will be lost.',
        description2: "Do you want to cancel the process?",
        context: context,
        onApprove: () => context.pushReplacementNamed('CreateQuestion'),
        onCancel: () {},
      );
      return false;
    }
    context.pushReplacementNamed('CreateQuestion');
    return false;
  }

  void _createQuestion(QuestionTypeRecord item) async {
    String? errorMessage;

    if (_model.textController1.text.isEmpty) {
      errorMessage = "The Question title field is required.";
    } else if (_model.textController2.text.isEmpty) {
      errorMessage = "The Question text field is required.";
    } else if (_model.dropDownValue == null) {
      errorMessage = "The length of Question field is required.";
    }

    if (errorMessage != null) {
      SnackBarService.show(
        context: context,
        title: errorMessage,
        type: SnackBarType.error,
      );
      return;
    }

    var typeReference = serializeParam(
      item.reference,
      ParamType.DocumentReference,
    );

    await QuestionNewRecord.collection.doc().set(
          createQuestionNewRecordData(
            questionTitle: _model.textController1.text,
            questionText: _model.textController2.text,
            questionType: typeReference,
            questionDuration:
                _model.dropDownValue?.title ?? QuestionLengthType.fiveDay.title,
            price:
                _model.dropDownValue?.money ?? QuestionLengthType.fiveDay.money,
            onSale: true,
          ),
        );

    context.pushReplacementNamed(
      'CreateQuestionSuccessfully',
      queryParameters: {
        'title': _model.textController1.text,
        'time': _model.dropDownValue?.title,
        'typeReceived': serializeParam(
          item.reference,
          ParamType.DocumentReference,
        ),
      }.withoutNulls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuestionTypeRecord>(
      stream: QuestionTypeRecord.getDocument(widget.typeReceived!),
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
        final item = snapshot.data!;
        return WillPopScope(
          onWillPop: () => _cancelQuestion(context),
          child: Scaffold(
            key: scaffoldKey,
            body: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'assets/images/page_background@2x.png',
                  ).image,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          margin: EdgeInsets.all(16),
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    10.0,
                                    10.0,
                                    10.0,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () => _cancelQuestion(context),
                                        child: Icon(Icons.arrow_back_ios),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          item.name,
                                          style: FlutterFlowTheme.of(context)
                                              .displaySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormFieldWidget(
                                  labelText: 'Question title',
                                  hintText: 'insert question title here',
                                  controller: _model.textController1,
                                  validator: _model.textController1Validator
                                      .asValidator(context),
                                ),
                                SizedBox(height: 20),
                                TextFormFieldWidget(
                                  labelText: 'Question text',
                                  hintText: 'insert question text here',
                                  maxLines: 10,
                                  minLines: 3,
                                  controller: _model.textController2,
                                  validator: _model.textController2Validator
                                      .asValidator(context),
                                ),
                                SizedBox(height: 20),
                                DropdownButton2<QuestionLengthType?>(
                                  value: _model.dropDownValue,
                                  customButton: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      border: Border.all(color: Colors.black26),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: AutoSizeText(
                                              _model.dropDownValue != null
                                                  ? (_model.dropDownValue
                                                          as QuestionLengthType)
                                                      .title
                                                  : "Please select length of time question is live",
                                              maxLines: 1,
                                            ),
                                          ),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ),
                                  underline: SizedBox(),
                                  dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                  )),
                                  isExpanded: true,
                                  items: [
                                    QuestionLengthType.fiveMinute,
                                    QuestionLengthType.fiftyMinute,
                                    QuestionLengthType.fiveDay,
                                  ]
                                      .map(
                                        (e) =>
                                            DropdownMenuItem<QuestionLengthType>(
                                          value: e,
                                          child: Text(e.title),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) => setState(
                                    () => _model.dropDownValue = val,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0,
                                    10.0,
                                    10.0,
                                    10.0,
                                  ),
                                  child: Text(
                                    'The price to ask this question is: ',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Roboto',
                                          fontSize: 22.0,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0,
                                      10.0,
                                      10.0,
                                      10.0,
                                    ),
                                    child: Text(
                                      "\$${_model.dropDownValue?.money ?? '0.0'}",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Roboto',
                                            color: Color(0xE339D261),
                                            fontSize: 36.0,
                                          ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ButtonWidget(
                                    title: 'Submit Question',
                                    onPressed: () async => _createQuestion(item),
                                  ),
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60,
                                  child: ButtonWidget(
                                    title: 'View list of questions',
                                    color: Theme.of(context).disabledColor,
                                    onPressed: () => _cancelQuestion(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
