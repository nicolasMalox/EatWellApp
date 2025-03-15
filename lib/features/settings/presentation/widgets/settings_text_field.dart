import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';

// SettingsTextField is a reusable CupertinoTextField designed for input in settings screens.
class SettingsTextField extends StatelessWidget {
  // TextEditingController to manage the text being edited.
  final TextEditingController controller;
  // Placeholder text to display when the field is empty.
  final String placeholder;
  // Optional parameter to specify the keyboard type, default is plain text.
  final TextInputType keyboardType;

  const SettingsTextField({
    required this.controller,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        keyboardType: keyboardType,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.primaryGrey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
