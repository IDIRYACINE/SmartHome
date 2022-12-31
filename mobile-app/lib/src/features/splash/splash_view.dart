import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/state/home_bloc.dart';
import 'package:smarthome_algeria/src/services/localDatabase/service.dart';
import 'package:smarthome_algeria/src/services/servicesProvider/service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));

    ServiceMessage loadHomes =
        DatabaseMessageBuilder.selectAllHomesMessage((homes) {
      AppNavigator.pushNamedReplacement(dashboardRoute);

      BlocProvider.of<HomeBloc>(context).add(LoadAllHomes(homes));
    });

    ServicesProvider.instance.sendMessage(loadHomes);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
