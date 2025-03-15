import 'package:flutter/cupertino.dart';

// SettingsDialog is a reusable CupertinoAlertDialog for confirming critical actions, such as data deletion.
class SettingsDialog extends StatelessWidget {
  // Callback function to be executed when the 'Delete' button is pressed.
  final Function() onPressed;

  const SettingsDialog({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Delete Data"),
      content: Text("Are you sure you want to delete all data?"),
      actions: [
        CupertinoDialogAction(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text("Delete"),
          onPressed: () => onPressed(),
        ),
      ],
    );
  }
}
