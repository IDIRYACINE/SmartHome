import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/services_store.dart';

import 'src/app.dart';
import 'src/core/settings/settings_controller.dart';
import 'src/core/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  Directory appDir = await  getApplicationDocumentsDirectory();

  ServicesProvider.getInstance(appDir.path);


  runApp(MyApp(settingsController: settingsController));
}
