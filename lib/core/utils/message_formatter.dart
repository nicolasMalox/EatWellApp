import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';

// MessageFormatter is a utility class to format AI-generated messages based on specific markup.
class MessageFormatter {
  // Method to build formatted responses from a raw text input.
  static Widget buildFormattedResponse(String text) {
    // Splitting the text by double newlines to parse individual lines as distinct elements.
    List<String> lines = text.split("\n\n");
    List<Widget> widgets = [];
    String? lastSubtitle;
    // Using a map to structure content under each subtitle.
    Map<String, List<String>> structuredContent = {};

    for (String line in lines) {
      line = line.trim();

      // Parsing titles denoted by single asterisks.
      if (line.startsWith("*") && !line.startsWith("**") && !line.startsWith("***") && line.endsWith("*")) {
        String title = line.replaceAll("*", "").trim();
        widgets.add(_buildTitle(title));
      }
      // Parsing subtitles denoted by double asterisks.
      else if (line.startsWith("**") && !line.startsWith("***")) {
        String subtitle = line.replaceAll("**", "").trim();
        lastSubtitle = subtitle;
        structuredContent.putIfAbsent(lastSubtitle, () => []);
      }
      // Parsing subcontent under subtitles, denoted by triple asterisks.
      else if (line.startsWith("***")) {
        if (lastSubtitle != null) {
          structuredContent[lastSubtitle]!.add(line.replaceAll("***", "").trim());
        }
      }
      // Handling regular text without markup.
      else if (!line.startsWith("*") && !line.startsWith("**") && !line.startsWith("***")) {
        widgets.add(_buildText(line));
      }
    }

    // Building widgets for each structured content section.
    structuredContent.forEach((key, value) {
      widgets.add(_buildExpandableContent(key, value));
    });

    // Returning a container with all the formatted text widgets.
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        constraints: BoxConstraints(maxWidth: 320),
        decoration: BoxDecoration(
          color: AppTheme.primaryGrey,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ),
      ),
    );
  }

  // Helper method to build a title widget.
  static Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          color: AppTheme.primaryBlack,
        ),
      ),
    );
  }

  // Helper method to build a text widget for regular content.
  static Widget _buildText(String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          color: AppTheme.primaryBlack,
        ),
      ),
    );
  }

  // Helper method to build expandable content sections for subtitles with details.
  static Widget _buildExpandableContent(String subtitle, List<String> content) {
    ValueNotifier<bool> isExpanded = ValueNotifier(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => isExpanded.value = !isExpanded.value,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // Builder to dynamically expand or collapse content based on user interaction.
        ValueListenableBuilder<bool>(
          valueListenable: isExpanded,
          builder: (context, expanded, child) {
            return expanded
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content.map((e) => _buildText(e)).toList(),
                    ),
                  )
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
