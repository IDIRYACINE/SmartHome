import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';

class AppBottomBar extends StatefulWidget {
  const AppBottomBar({super.key});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  void onItemSelected(int index) {
    setState(() {
      AppNavigator.setBottomBarIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppNavigator.bottomBarIndex,
      builder: (context, index, child) => BottomNavigationBar(
        currentIndex: index,
        onTap: onItemSelected,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications),
            label: AppLocalizations.of(context)!.notifications,
          ),
        ],
      ),
    );
  }
}
