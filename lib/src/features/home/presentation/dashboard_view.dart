import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/dashboard/presentation/dashboard_view.dart';
import 'package:smarthome_algeria/src/features/notifications/presentation/notification_view.dart';
import 'bottom_bar.dart';
import 'home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<Widget> screens = const [
    DashboardView(),
    NotificationsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<int>(
            valueListenable: AppNavigator.bottomBarIndex,
            builder: (context, index, child) => screens[index]),
      ),
      bottomNavigationBar: const AppBottomBar(),
    );
  }
}
