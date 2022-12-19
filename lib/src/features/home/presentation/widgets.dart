import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/presentation/create_action_popup.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

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
        const Flexible(child: _HomeLabel())
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(112.0);
}

class _HomeLabel extends StatelessWidget {

  const _HomeLabel({this.paddings = 4.0});
  final double paddings;

  @override
  Widget build(BuildContext context) {
    const defaultName = 'Dashboard';

    return Column(
      children: [
        Text(
          defaultName,
          style: Theme.of(context).textTheme.headline6,
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.all(paddings),
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
