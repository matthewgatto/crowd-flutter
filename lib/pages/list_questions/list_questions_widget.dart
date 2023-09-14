import 'package:crowds/widgets/base_scaffold_list_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

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
  Widget _itemWidget(QuestionNewRecord item) {
    return InkWell(
      onTap: () async {
        context.pushReplacementNamed(
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
            'price': serializeParam(
              item.price,
              ParamType.double,
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

  String _getAverageReward(List<QuestionNewRecord>? data) {
    List<QuestionNewRecord> items = data ?? [];
    double total = 0.0;
    var length = 0;
    items.forEach((element) {
      if (element.price != null) {
        total += (element.price ?? 0.0);
        length++;
      }
    });
    var average = total / length;
    return "\$${average.isNaN ? 0.0 : average}";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionNewRecord>>(
      stream: queryQuestionNewRecord(),
      builder: (context, snapshot) => BaseScaffoldListWidget(
        title: 'Select a questions: ',
        child: Builder(
          builder: (context) {
            if (snapshot.data == null) return SizedBox(width: double.infinity);
            List<QuestionNewRecord> items = snapshot.data!;

            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) => _itemWidget(items[index]),
            );
          },
        ),
        bottomWidget: Padding(
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
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 20.0),
                child: Text(
                  'Right now the average reward for answering a question is: ',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                  _getAverageReward(snapshot.data),
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
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
    );
  }
}
