import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';
import '../domain/type_aliases.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLabel extends StatelessWidget {
  const HomeLabel({
    super.key,
    this.padding = 4.0,
    this.currentHome,
    required this.onHomeSelected,
  });

  final Home? currentHome;
  final double padding;
  final HomeCallback onHomeSelected;

  void onTap() {
    AppNavigator.displayDialog(_SelectHomePopup(onHomeSelected),
        barrierColor: Colors.grey.withOpacity(0.75));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            currentHome?.name ?? AppLocalizations.of(context)!.noHomes,
          ),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}

class _SelectHomePopup extends StatelessWidget {
  const _SelectHomePopup(this.onSelectHome);

  final HomeCallback onSelectHome;

  void onHomeSelected(Home home) {
    onSelectHome(home);
  }

  Widget buildHomeCard(BuildContext context, Home home) {
    return GestureDetector(
      onTap: () => onHomeSelected(home),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              home.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homesList = BlocProvider.of<AppBloc>(context).state.homes;

    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: SizedBox(
        height: 300,
        width: 500,
        child: ListView.separated(
            itemBuilder: (context, index) =>
                buildHomeCard(context, homesList[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: homesList.length),
      ),
    );
  }
}
