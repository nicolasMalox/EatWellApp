import 'package:flutter_eat_well/features/settings/models/user_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SettingsNotifier manages user settings using SharedPreferences for persistent storage.
class SettingsNotifier extends StateNotifier<UserSettings> {
  // Constructor initializes with default empty settings and loads existing settings from SharedPreferences.
  SettingsNotifier() : super(UserSettings.empty()) {
    _loadSettings();
  }

  // Private method to load settings from SharedPreferences.
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    // Loads user settings from SharedPreferences and updates the state.
    state = UserSettings.fromJson({
      'name': prefs.getString('name') ?? '',
      'weight': prefs.getDouble('weight') ?? 0,
      'height': prefs.getDouble('height') ?? 0,
      'allergies': prefs.getString('allergies') ?? '',
    });
  }

  // Method to update user settings both in state and SharedPreferences.
  Future<void> updateSettings(UserSettings newSettings) async {
    final prefs = await SharedPreferences.getInstance();

    // Update state with new settings.
    state = newSettings;

    // Save updated settings to SharedPreferences.
    await prefs.setString('name', newSettings.name);
    await prefs.setDouble('weight', newSettings.weight);
    await prefs.setDouble('height', newSettings.height);
    await prefs.setString('allergies', newSettings.allergies);
  }
}

// Provider definition for settings state using StateNotifierProvider.
final settingsProvider = StateNotifierProvider<SettingsNotifier, UserSettings>((ref) => SettingsNotifier());
