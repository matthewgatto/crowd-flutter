import 'package:flutter/material.dart';

class DialogService {
  static Widget _getActionButton({
    required Function() function,
    required String title,
    required BuildContext context,
  }) {
    return TextButton(
      child: Text(title),
      onPressed: () {
        function.call();
        Navigator.of(context).pop();
      },
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    bool barrierDismissible = false, // user must tap button!
    String? description,
    String? description2,
    Function()? onYes,
    Function()? onNo,
    Function()? onApprove,
    Function()? onCancel,
  }) async {
    var actions = <Widget>[];
    if (onYes != null) {
      actions.add(
        _getActionButton(
          title: "Yes",
          context: context,
          function: onYes,
        ),
      );
    }
    if (onNo != null) {
      actions.add(
        _getActionButton(
          title: "No",
          context: context,
          function: onNo,
        ),
      );
    }
    if (onApprove != null) {
      actions.add(
        _getActionButton(
          title: "Approve",
          context: context,
          function: onApprove,
        ),
      );
    }
    if (onCancel != null) {
      actions.add(
        _getActionButton(
          title: "Cancel",
          context: context,
          function: onCancel,
        ),
      );
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                description != null ? Text(description) : SizedBox(),
                description2 != null ? Text(description2) : SizedBox(),
              ],
            ),
          ),
          actions: actions,
        );
      },
    );
  }
}
