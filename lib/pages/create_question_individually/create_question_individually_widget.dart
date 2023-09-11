import 'package:crowds/widgets/button_widget.dart';
import 'package:crowds/widgets/text_form_field_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
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

  void _createQuestion(QuestionTypeRecord item) async {
    var typeReference = serializeParam(
      item.reference,
      ParamType.DocumentReference,
    );

    await QuestionNewRecord.collection.doc().set(
          createQuestionNewRecordData(
            questionTitle: _model.textController1.text,
            questionText: _model.textController2.text,
            questionType: typeReference,
            onSale: true,
          ),
        );

    context.pushNamed(
      'CreateQuestionSuccessfully',
      queryParameters: {
        'title': _model.textController1.text,
        'time': _model.dropDownValueController?.value,
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
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).splash,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () async {
                context.pushReplacementNamed('CreateQuestion');
              },
            ),
            title: Text('Asking a question ...'),
          ),
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
                                10.0, 10.0, 10.0, 10.0),
                            child: Text(
                              item.name,
                              style: FlutterFlowTheme.of(context).displaySmall,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormFieldWidget(
                            labelText: 'Question title',
                            hintText: 'insert question title here',
                            controller:_model.textController1,
                            validator: _model.textController1Validator
                                .asValidator(context),
                          ),
                          SizedBox(height: 20),
                          TextFormFieldWidget(
                            labelText: 'Question text',
                            hintText: 'insert question text here',
                            maxLines: 10,
                            minLines: 3,
                            controller:_model.textController2,
                            validator: _model.textController2Validator
                                .asValidator(context),
                          ),
                          SizedBox(height: 20),
                          FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController ??=
                                FormFieldController<String>(null),
                            options: ['5 minutes', '50 minutes', '5 days'],
                            onChanged: (val) =>
                                setState(() => _model.dropDownValue = val),
                            width: double.infinity,
                            height: 50.0,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Roboto',
                                  color: FlutterFlowTheme.of(context)
                                      .customColor4,
                                ),
                            hintText:
                                'Please select length of time question is live',
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryText,
                              size: 24.0,
                            ),
                            fillColor: FlutterFlowTheme.of(context).accent3,
                            elevation: 2.0,
                            borderColor:
                                FlutterFlowTheme.of(context).alternate,
                            borderWidth: 2.0,
                            borderRadius: 8.0,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            hidesUnderline: true,
                            isSearchable: false,
                            isMultiSelect: false,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Text(
                              'The price to ask this question is: ',
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
                                  10.0, 10.0, 10.0, 10.0),
                              child: Text(
                                formatNumber(
                                  random_data.randomDouble(0.5, 1.25),
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: '\$',
                                ),
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
                              onPressed: () => _createQuestion(item),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ButtonWidget(
                              title: 'View list of questions',
                              color: Theme.of(context).disabledColor,
                              onPressed: () {
                                context.pushReplacementNamed('ListQuestions');
                              },
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
        );
      },
    );
  }
}
