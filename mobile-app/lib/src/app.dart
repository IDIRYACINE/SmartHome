import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';
import 'package:smarthome_algeria/src/features/room/state/bloc.dart';

import 'core/settings/settings_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RoomBloc? roomBLoc;

  HomeBloc? homeBloc;
  DevicesBloc? devicesBloc;

  @override
  void initState() {
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    devicesBloc ??= DevicesBloc();
    roomBLoc ??= RoomBloc(devicesBloc!);
    homeBloc ??= HomeBloc(roomBLoc!);

    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) => homeBloc!,
            ),
            BlocProvider<RoomBloc>(
              create: (context) => roomBLoc!,
            ),
            BlocProvider<DevicesBloc>(
              create: (context) => devicesBloc!,
            ),
          ],
          child: MaterialApp(
            locale: widget.settingsController.locale,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
              Locale('ar', '')
            ],
            navigatorKey: AppNavigator.key,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appTitle,
            theme: ThemeData(),
            darkTheme: ThemeData.dark(),
            themeMode: widget.settingsController.themeMode,
            onGenerateRoute: AppRouter.generateRoutes,
          ),
        );
      },
    );
  }
}
