import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/features/chat/presentation/widgets/chat_input_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_message_widget.dart';

// ChatScreen displays the chat interface using a Cupertino design.
class ChatScreen extends HookConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching chat messages state to rebuild the widget whenever messages update.
    final chatMessages = ref.watch(chatProvider);
    // Controllers for text input and scrolling within the chat.
    final chatController = TextEditingController();
    final scrollController = ScrollController();

    return CupertinoPageScaffold(
      // Configuring the top navigation bar.
      navigationBar: CupertinoNavigationBar(
        middle: Text("Chat with EatWell AI"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Button to clear the chat.
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.trash, color: CupertinoColors.systemRed),
              onPressed: () => _showClearChatConfirmation(context, ref),
            ),
            // Button to navigate to settings.
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Icon(CupertinoIcons.settings),
              onPressed: () => _onNavigateToSettings(context),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ListView to display chat messages.
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final message = chatMessages[index];
                  return ChatMessageWidget(message: message);
                },
              ),
            ),
            // Input widget for sending messages.
            Padding(
              padding: EdgeInsets.all(8.0),
              child: ChatInputWidget(
                controller: chatController,
                onPressed: (text) => _onSendMessage(ref, text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle sending messages.
  void _onSendMessage(WidgetRef ref, String text) {
    ref.read(chatProvider.notifier).sendMessage(text);
  }

  // Method to clear chat messages.
  void _onClearChat(BuildContext context, WidgetRef ref) {
    ref.read(chatProvider.notifier).clearChat();
    Navigator.pop(context);
  }

  // Method to navigate to the settings screen.
  void _onNavigateToSettings(BuildContext context) {
    context.push('/settings');
  }

  // Method to show a confirmation dialog before clearing the chat.
  void _showClearChatConfirmation(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Clear Chat"),
          content: Text("Are you sure you want to delete all messages?"),
          actions: [
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text("Clear"),
              onPressed: () => _onClearChat(context, ref),
            ),
          ],
        );
      },
    );
  }
}
