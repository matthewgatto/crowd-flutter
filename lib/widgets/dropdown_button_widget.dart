import 'package:crowds/flutter_flow/flutter_flow_theme.dart';
import 'package:crowds/widgets/drop_down_view_model.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  final String title;
  final List<DropDownViewModel> items;
  final DropDownViewModel? value;
  final ValueChanged<DropDownViewModel?>? onChanged;

  const DropDownWidget({
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var borderColor = Colors.black.withOpacity(0.5);
    var backGroundColor = Color(0xffF5F5F5);
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: backGroundColor,
            border: Border.all(color: borderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: SizedBox(),
            items: items
                .map((element) => DropdownMenuItem<String>(
                      value: element.value,
                      child: Text(element.title),
                    ))
                .toList(),
            value: value?.value,
            onChanged: (value) {
              var item = items.where((element) => element.value == value);
              if (item.isNotEmpty) {
                onChanged?.call(item.first);
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          padding: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, backGroundColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Text(
            title,
            style: FlutterFlowTheme.of(context).labelSmall.copyWith(
              color: borderColor,
            ),
          ),
        ),
      ],
    );
  }
}
