import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/presentation/device_panel_view.dart';
import 'package:smarthome_algeria/src/features/home/presentation/create_action_popup.dart';

class DashboardAppBar extends StatelessWidget  {
  const DashboardAppBar({super.key});

  final int homeLabelFlex = 1;
  final int deviceControlPanelFlex = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              AppNavigator.displayDialog(const CreateActionPopup());
            },
          ),
          actions: const [
            ProfileButton(),
          ],
        ),
        Flexible(
          flex: homeLabelFlex,
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const _HomeLabel(),
          ),
        ),
        
      ],
    );
  }

}

class _HomeLabel extends StatelessWidget {
  // ignore: unused_element
  const _HomeLabel({this.padding = 4.0});

  final double padding;

  @override
  Widget build(BuildContext context) {
    const defaultName = 'Dashboard';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          defaultName,
          style: Theme.of(context).textTheme.headline6,
        ),
        SizedBox(height: padding,width: double.infinity,),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home),
              Text(
                'Home',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {},
    );
  }
}
