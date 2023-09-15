import 'package:crowds/pages/list_questions/question_item_widget.dart';
import 'package:crowds/widgets/base_scaffold_list_widget.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class ListQuestionsWidget extends StatelessWidget {
  const ListQuestionsWidget({
    Key? key,
    this.gameCode,
  }) : super(key: key);

  final int? gameCode;

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
    return "\$${average.isNaN ? 0.0 : average.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QuestionNewRecord>>(
      stream: queryQuestionNewRecord(
        queryBuilder: (p0) => p0.where(
          'finishTimeAt',
          isGreaterThan: DateTime.now(),
        ),
      ),
      builder: (context, snapshot) => BaseScaffoldListWidget(
        title: 'Select a questions: ',
        child: Builder(
          builder: (context) {
            if (snapshot.data == null) return SizedBox(width: double.infinity);
            List<QuestionNewRecord> items = snapshot.data!;

            return ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemBuilder: (context, index) => QuestionItemWidget(
                item: items[index],
              ),
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
