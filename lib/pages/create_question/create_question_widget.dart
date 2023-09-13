import 'package:crowds/widgets/button_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'create_question_model.dart';
export 'create_question_model.dart';

class CreateQuestionWidget extends StatefulWidget {
  const CreateQuestionWidget({Key? key}) : super(key: key);

  @override
  _CreateQuestionWidgetState createState() => _CreateQuestionWidgetState();
}

class _CreateQuestionWidgetState extends State<CreateQuestionWidget> {
  late CreateQuestionModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateQuestionModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  void _showDetailPage(QuestionTypeRecord questionTyp) {
    var destinationPage = 'CreateQuestionIndividually';

    context.pushReplacementNamed(
      destinationPage,
      queryParameters: {
        'typeReceived': serializeParam(
          questionTyp.reference,
          ParamType.DocumentReference,
        ),
      }.withoutNulls,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget getItemCard(QuestionTypeRecord questionTyp) {
      return InkWell(
        onTap: () => _showDetailPage(questionTyp),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.check_box_outline_blank),
                SizedBox(width: 16),
                Text(
                  questionTyp.displayName ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Roboto',
                        color: FlutterFlowTheme.of(context).customColor4,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return StreamBuilder<List<QuestionTypeRecord>>(
      stream: queryQuestionTypeRecord(),
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
        List<QuestionTypeRecord> questionTypes = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).splash,
            title: Text('Question type'),
          ),
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 36),
                Text(
                  'Choose a question type',
                  style: FlutterFlowTheme.of(context).displaySmall,
                ),
                SizedBox(height: 36),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
                    itemCount: questionTypes.length,
                    itemBuilder: (context, index) {
                      return getItemCard(questionTypes[index]);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 26),
                  child: ButtonWidget(
                    title: "Cancel",
                    onPressed: () async {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
