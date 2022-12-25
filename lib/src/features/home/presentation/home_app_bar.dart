import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/core/state_manager/app_bloc.dart';
import 'package:smarthome_algeria/src/features/dashboard/presentation/dashboard_label.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';


class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  final int homeLabelFlex = 1;
  final int deviceControlPanelFlex = 3;

  void onHomeSelected(Home home, BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(SelectHome(home));
    AppNavigator.pop();
  }

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
          title: BlocSelector<AppBloc, AppState, Home?>(
              selector: (state) => state.currentHome,
              builder: (context, home) => HomeLabel(
                onHomeSelected: (home) => onHomeSelected(home, context),
                currentHome: home,
              ),
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

