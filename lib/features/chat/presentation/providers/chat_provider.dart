import 'dart:developer';
import 'package:flutter_eat_well/core/utils/chat_prompt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../settings/presentation/providers/settings_provider.dart';
import '../../models/chat_message.dart';

// ChatNotifier manages the chat state using Riverpod for state management.
class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final Ref ref;
  final GenerativeModel _geminiModel;

  // Constructor initializes the AI model and loads initial configurations.
  ChatNotifier(this.ref, this._geminiModel) : super([]) {
    _initialize();
  }

  // Private method to load user settings on provider initialization.
  Future<void> _initialize() async {
    final userSettings = ref.read(settingsProvider);
    log("User settings loaded: ${userSettings.name}");
  }

  // Method to send messages. Includes logic to interact with Gemini AI.
  Future<void> sendMessage(String userMessage) async {
    final userSettings = ref.read(settingsProvider);
    final prompt = ChatPrompt.generatePrompt(userSettings, userMessage);

    // Add user message to the state.
    state = [...state, ChatMessage(text: userMessage, isUser: true)];

    try {
      // Generate content based on the user's message using the Gemini AI model.
      final content = [Content.text(prompt)];
      final response = await _geminiModel.generateContent(content);

      // Update state with the AI response.
      state = [
        ...state,
        ChatMessage(text: response.text ?? "I don't have a response at the moment.", isUser: false),
      ];
      log(response.text!);
    } catch (e) {
      // Handle errors and update state with a default error message.
      state = [...state, ChatMessage(text: "Error connecting to AI.", isUser: false)];
    }
  }

  // Method to clear all chat messages.
  void clearChat() {
    state = [];
  }
}

// Provider definition for chat state using StateNotifierProvider.
final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
    return ChatNotifier(ref, model);
  },
);
