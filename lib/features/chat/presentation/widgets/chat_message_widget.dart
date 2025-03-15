import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/message_formatter.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';
import '../../models/chat_message.dart';

// ChatMessageWidget displays individual chat messages in the chat interface.
class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;

  // Constructor requires a ChatMessage object to render.
  const ChatMessageWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    // If the message is from the AI (not the user), format it differently.
    if (!message.isUser) {
      // Uses a utility class to format AI responses.
      return MessageFormatter.buildFormattedResponse(message.text);
    }

    // Align user messages to the right and format accordingly.
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Color(0xFF065F46), // Dark green color for user messages.
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: AppTheme.primaryWhite, // White text for readability.
            fontSize: 16,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none, // Ensures text is not underlined.
          ),
        ),
      ),
    );
  }
}
