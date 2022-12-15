
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_panel_view.dart';

import 'widgets.dart';

class DashboardView extends StatelessWidget{
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DashboardAppBar(),
      body: DeviceControlPanelView(),
    );
  }
}