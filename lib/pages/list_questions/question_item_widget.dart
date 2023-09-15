import 'dart:async';

import 'package:crowds/backend/schema/question_new_record.dart';
import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:crowds/util/date_time_extention.dart';
import 'package:crowds/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class QuestionItemWidget extends StatefulWidget {
  final QuestionNewRecord item;
  const QuestionItemWidget({required this.item, super.key});

  @override
  State<QuestionItemWidget> createState() => _QuestionItemWidgetState();
}

class _QuestionItemWidgetState extends State<QuestionItemWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 1),
          (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  double _getProgressIndicatorValue() {
    var start = widget.item.createdAt ?? DateTime.now();
    var end = widget.item.finishTimeAt ?? DateTime.now();
    var now = DateTime.now();
    if (now.isBefore(start)) {
      return 0.0;
    } else if (now.isAfter(end)) {
      return 1.0;
    }
    var diffWithStart = now.difference(start);
    var diffWithEnd = end.difference(now);
    var result = diffWithStart.inSeconds / diffWithEnd.inSeconds;

    if (result.isNaN) {
      return 1.0;
    } else if (result > 1.0) {
      return 1.0;
    } else if (result < 0.0) {
      return 0.0;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.pushReplacementNamed(
          'AnsweringQuestion',
          queryParameters: {
            'titleReceived': serializeParam(
              widget.item.questionTitle,
              ParamType.String,
            ),
            'id': serializeParam(
              widget.item.id,
              ParamType.String,
            ),
            'questionReceived': serializeParam(
              widget.item.questionText,
              ParamType.String,
            ),
            'price': serializeParam(
              widget.item.price,
              ParamType.double,
            ),
          }.withoutNulls,
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.question_answer_outlined),
                  SizedBox(width: 16),
                  Text(
                    widget.item.questionTitle,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: _getProgressIndicatorValue(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
