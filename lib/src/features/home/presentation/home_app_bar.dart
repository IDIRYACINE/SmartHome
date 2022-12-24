import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/presentation/create_action_popup.dart';


class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
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
       
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight (kToolbarHeight);
}


class ProfileButton extends StatelessWidget {
  const ProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        AppNavigator.pushNamed(settingsRoute);
      },
    );
  }
}
