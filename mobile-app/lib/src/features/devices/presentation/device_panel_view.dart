import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';


class DeviceControlPanelView extends StatelessWidget {
  final double padding = 8;
  final DeviceClickCallback? onPressed;

  const DeviceControlPanelView({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: deviceArchetypes.length,
        itemBuilder: (context, index) => DeviceSummaryCard(
          deviceArchetype: deviceArchetypes[index],
        ),
      ),
    );
  }
}

class DeviceTypePanelView extends StatefulWidget {
  const DeviceTypePanelView({super.key, this.padding = 4, required this.onPressed});

  final double padding;
  final DeviceTypePressed onPressed;

  @override
  State<DeviceTypePanelView> createState() => _DeviceTypePanelViewState();
}

class _DeviceTypePanelViewState extends State<DeviceTypePanelView> {

  VoidCallback? turnOffLastSelected;

  void registerLastSelectedCallback(VoidCallback callback){
    if(turnOffLastSelected != callback){
      turnOffLastSelected?.call();
      turnOffLastSelected = callback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.2;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: height),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: deviceArchetypes.length,
        itemBuilder: (context, index) => DeviceTypeCard(
          deviceArchetype: deviceArchetypes[index],
          index: index,
          onPressed: widget.onPressed,
          registerTurnOffCallback: registerLastSelectedCallback,
        ),
      ),
    );
  }
}
