import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/services_store.dart';

import 'src/app.dart';
import 'src/core/settings/settings_controller.dart';
import 'src/core/settings/settings_service.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  ServicesProvider.getInstance();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(MyApp(settingsController: settingsController));
}