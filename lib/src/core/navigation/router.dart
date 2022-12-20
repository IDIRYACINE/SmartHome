
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/edit_device_view.dart';
import 'package:smarthome_algeria/src/features/home/presentation/dashboard_view.dart';
import 'package:smarthome_algeria/src/features/home/presentation/home_editor_view.dart';
import 'package:smarthome_algeria/src/features/room/presentation/room_editor_view.dart';

import 'routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case dashboardRoute:
        return getPageRoute(
          settings: settings,
          view: const DashboardView(),
        );
      case deviceEditorRoute:
        return getPageRoute(
          settings: settings,
          view: const DeviceEditorView(),
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
      default:
        return getPageRoute(
          settings: settings,
          view: const DashboardView(),
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