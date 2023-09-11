import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'list_questions_model.dart';
export 'list_questions_model.dart';

class ListQuestionsWidget extends StatefulWidget {
  const ListQuestionsWidget({
    Key? key,
    this.gameCode,
  }) : super(key: key);

  final int? gameCode;

  @override
  _ListQuestionsWidgetState createState() => _ListQuestionsWidgetState();
}

class _ListQuestionsWidgetState extends State<ListQuestionsWidget> {
  late ListQuestionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListQuestionsModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _itemWidget(QuestionNewRecord item) {
    return InkWell(
      onTap: () async {
        context.pushNamed(
          'AnsweringQuestion',
          queryParameters: {
            'titleReceived': serializeParam(
              item.questionTitle,
              ParamType.String,
            ),
            'questionReceived': serializeParam(
              item.questionText,
              ParamType.String,
            ),
          }.withoutNulls,
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.question_answer_outlined),
              SizedBox(width: 16),
              Text(
                item.questionTitle,
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionNewRecord>>(
      stream: queryQuestionNewRecord(),
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
        List<QuestionNewRecord> columnQuestionNewRecordList = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).splash,
            title: Text('Answering...'),
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
            child: Container(
              padding: EdgeInsetsDirectional.fromSTEB(
                24.0,
                24.0,
                24.0,
                24.0,
              ),
              color: FlutterFlowTheme.of(context).customColor5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      'Select one of the following questions: ',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.separated(
                          padding: EdgeInsets.symmetric(
                            vertical: 21,
                            horizontal: 16,
                          ),
                          itemCount: columnQuestionNewRecordList.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 8,
                          ),
                          itemBuilder: (context, index) => _itemWidget(
                            columnQuestionNewRecordList[index],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                Color(0xffEEEEEE),
                                Color(0x7eeeeeee),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 20,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                Color(0xffEEEEEE),
                                Color(0x7eeeeeee),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        20.0,
                        0.0,
                        20.0,
                        20.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 20.0, 20.0, 20.0),
                            child: Text(
                              'Right now the average reward for answering a question is: ',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xFF4B39EF),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0.0,
                              10.0,
                              0.0,
                              10.0,
                            ),
                            child: Text(
                              valueOrDefault<String>(
                                formatNumber(
                                  random_data.randomDouble(1.5, 3.7),
                                  formatType: FormatType.decimal,
                                  decimalType: DecimalType.automatic,
                                  currency: '\$',
                                ),
                                '2',
                              ),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Roboto',
                                    color: Color(0xE339D261),
                                    fontSize: 48.0,
                                  ),
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
