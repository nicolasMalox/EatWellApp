class ChatPrompt {
  // Static method to generate a chat prompt for the AI, integrating user settings and the user's message.
  static String generatePrompt(userSettings, String userMessage) {
    // Returns a formatted string that combines user information and the user's specific request.
    return """
My name is ${userSettings.name}, I weigh ${userSettings.weight} kg, I am ${userSettings.height} cm tall, 
and I am allergic to ${userSettings.allergies}. I want a healthier version of this dish: "$userMessage".

Please follow these formatting rules in your response:
- Keep the response concise but start by saying hello and being friendly and add emojis.
- Use *Title* for the main dish name.
- Use **Subtitle** for sections like Ingredients, Preparation, and Allergies.
- Use ***Subcontent*** for details within each subtitle and add emojis.
- The introduction should not have any asterisks.

Every response must include these sections:
**Ingredients**
**Preparation**
**Allergies**
""";
  }
}
