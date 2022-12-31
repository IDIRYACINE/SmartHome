
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_archetype_view.dart';
import 'package:smarthome_algeria/src/features/home/presentation/home_view.dart';
import 'package:smarthome_algeria/src/features/home/presentation/home_editor_view.dart';
import 'package:smarthome_algeria/src/features/room/presentation/room_editor_view.dart';
import 'package:smarthome_algeria/src/core/settings/settings_controller.dart';
import 'package:smarthome_algeria/src/core/settings/settings_view.dart';
import 'package:smarthome_algeria/src/features/splash/splash_view.dart';

import 'routes.dart';

abstract class AppRouter {

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case dashboardRoute:
        return getPageRoute(
          settings: settings,
          view: const HomeView(),
        );
      case deviceEditorRoute:
        return getPageRoute(
          settings: settings,
          view:  DeviceEditorView(editorSettings :settings.arguments as DeviceEditorData),
        );
         case homeEditorRoute:
        return getPageRoute(
          settings: settings,
          view:  const HomeEditorView(),
        );
         case roomEditorRoute:
        return getPageRoute(
          settings: settings,
          view: const RoomEditorView(),
        );
        case settingsRoute :
        return getPageRoute(
          settings: settings,
          view:  SettingsView(controller: SettingsController.instance,),
        );
        case deviceArchetypeRoute:
        return getPageRoute(
          settings: settings,
          view:  DeviceArchetypeView(deviceArchetype :settings.arguments as DeviceArchetype),
        );
        
      default:
        return getPageRoute(
          settings: settings,
          view: const SplashView(),
        );
    }
  }

  static PageRoute<dynamic> getPageRoute({
    required RouteSettings settings,
    required Widget view,
  }) {
    return Platform.isIOS
        ? CupertinoPageRoute(settings: settings, builder: (_) => view)
        : MaterialPageRoute(settings: settings, builder: (_) => view);
  }
}