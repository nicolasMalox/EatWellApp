import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';
import 'package:flutter_eat_well/features/settings/presentation/providers/settings_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ChatInputWidget provides a text input field and send button for the chat interface.
class ChatInputWidget extends ConsumerWidget {
  final TextEditingController controller;
  final Function(String) onPressed;

  // Constructor requires a text controller and a function to handle when a message is sent.
  const ChatInputWidget({required this.controller, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching settings to determine if the user's profile is complete.
    final userSettings = ref.watch(settingsProvider);

    // Check if all required user information is provided.
    bool isUserInfoComplete = userSettings.name.isNotEmpty &&
        userSettings.weight > 0 &&
        userSettings.height > 0 &&
        userSettings.allergies.isNotEmpty;

    return Row(
      children: [
        // Text input field for typing messages.
        Expanded(
          child: CupertinoTextField(
            controller: controller,
            placeholder: "Type a message...",
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppTheme.primaryGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Send button that is enabled or disabled based on user profile completeness.
        CupertinoButton(
          onPressed: isUserInfoComplete ? () => _handleSend(context) : () => _showIncompleteProfileAlert(context),
          child: Icon(
            CupertinoIcons.paperplane_fill,
            color: isUserInfoComplete ? AppTheme.primaryColor : CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }

  // Handles sending the message if the input is not empty.
  void _handleSend(BuildContext context) {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      onPressed(text);
      controller.clear();
    }
  }

  // Shows an alert if the user's profile is incomplete and they try to send a message.
  void _showIncompleteProfileAlert(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Complete Your Profile"),
          content: Text("You need to provide your name, weight, height, and allergies before sending a message."),
          actions: [
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Go to Settings"),
              onPressed: () {
                Navigator.pop(context);
                context.push('/settings');
              },
            ),
          ],
        );
      },
    );
  }
}
