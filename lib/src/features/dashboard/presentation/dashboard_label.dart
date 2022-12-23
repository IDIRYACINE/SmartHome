
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/models/home.dart';

class HomeLabel extends StatelessWidget {
  const HomeLabel({super.key, this.padding = 4.0});

  final double padding;

  void onTap() {
    AppNavigator.displayDialog(const _SelectHomePopup(), barrierColor: Colors.grey.withOpacity(0.75));
  }

  @override
  Widget build(BuildContext context) {
    const defaultName = 'Idir Main Home';

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            defaultName,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}

class _SelectHomePopup extends StatelessWidget {
  const _SelectHomePopup();

  void onHomeSelected(Home home) {
    AppNavigator.pop(home);
  }

  Widget buildHomeCard(BuildContext context, Home home) {
    return GestureDetector(
      onTap: () => onHomeSelected(home),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            home.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Home> homes = [
      Home("Idir Main Home", 1),
      Home("Idir Second Home", 2),
      Home("Idir Third Home", 3),
    ];

    return 
      AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: SizedBox(
          height: 300,
          width: 500,
          child: ListView.separated(
              itemBuilder: (context, index) => buildHomeCard(context, homes[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemCount: homes.length),
        ),
      );
    
  }
}
