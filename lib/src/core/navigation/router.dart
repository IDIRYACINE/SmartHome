
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/home/presentation/dashboard_view.dart';

import 'routes.dart';

abstract class AppRouter {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case dashboardRoute:
        return getPageRoute(
          settings: settings,
          view: const DashboardView(),
        );
      // case Routes.login.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: LoginView(),
      //   );
      // case Routes.profile.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: ProfileView(),
      //   );
      // case Routes.settings.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: SettingsView(),
      //   );
      // case Routes.room.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: RoomView(),
      //   );
      // case Routes.stats.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: StatsView(),
      //   );
      // case Routes.device.routeName:
      //   return getPageRoute(
      //     settings: settings,
      //     view: DeviceView(),
      //   );
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