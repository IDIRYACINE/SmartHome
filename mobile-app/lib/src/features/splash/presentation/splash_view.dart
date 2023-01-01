import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/features/splash/domain/splash_controller.dart';

class SplashView extends StatefulWidget {
  SplashView({super.key});

  final SplashController controller = SplashController();

  @override
  State<StatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadHomesData(context);
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
