import 'package:flutter/cupertino.dart';
import 'package:flutter_eat_well/core/utils/theme.dart';
import 'package:flutter_eat_well/features/settings/models/user_settings.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_text_field.dart';
import '../widgets/settings_dialog.dart';

// SettingsScreen provides a user interface for editing and saving user settings.
class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the current settings to keep the UI updated.
    final userSettings = ref.watch(settingsProvider);
    // Controllers initialized with values from the user settings.
    final nameController = TextEditingController(text: userSettings.name);
    final weightController =
        TextEditingController(text: userSettings.weight == 0 ? '' : userSettings.weight.toString());
    final heightController =
        TextEditingController(text: userSettings.height == 0 ? '' : userSettings.height.toString());
    final allergyController = TextEditingController(text: userSettings.allergies);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Settings")),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text fields for user settings.
              SettingsTextField(controller: nameController, placeholder: "Name"),
              SettingsTextField(
                  controller: weightController, placeholder: "Weight (kg)", keyboardType: TextInputType.number),
              SettingsTextField(
                  controller: heightController, placeholder: "Height (cm)", keyboardType: TextInputType.number),
              SettingsTextField(controller: allergyController, placeholder: "Allergies"),
              Spacer(),
              // Button to save the settings.
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CupertinoButton(
                  onPressed: () => _onSaveSettings(
                      nameController, weightController, heightController, allergyController, ref, context),
                  color: AppTheme.primaryColor,
                  child: Text("Save", style: TextStyle(color: AppTheme.primaryWhite)),
                ),
              ),
              // Button to delete all user data.
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: CupertinoButton(
                  onPressed: () => showCupertinoDialog(
                    context: context,
                    builder: (context) => SettingsDialog(
                      onPressed: () => _onDelete(context, ref),
                    ),
                  ),
                  color: AppTheme.deleteButtonColor,
                  child: Text("Delete Data", style: TextStyle(color: AppTheme.primaryRed)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to handle saving settings.
  void _onSaveSettings(
      TextEditingController nameController,
      TextEditingController weightController,
      TextEditingController heightController,
      TextEditingController allergyController,
      WidgetRef ref,
      BuildContext context) {
    // Create a new UserSettings object with updated values.
    final updatedSettings = UserSettings(
      name: nameController.text,
      weight: double.tryParse(weightController.text) ?? 0,
      height: double.tryParse(heightController.text) ?? 0,
      allergies: allergyController.text,
    );
    // Update settings in the provider.
    ref.read(settingsProvider.notifier).updateSettings(updatedSettings);
    // Pop the current screen.
    context.pop();
  }

  // Function to handle deleting user data.
  void _onDelete(BuildContext context, WidgetRef ref) {
    // Reset user settings to empty.
    ref.read(settingsProvider.notifier).updateSettings(UserSettings.empty());
    // Close the dialog.
    Navigator.pop(context);
  }
}
