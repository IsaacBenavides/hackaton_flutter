import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/controllers/splash_controller.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final SplashController splashController = Provider.of(context);
    splashController.goToOffers(context);
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/ct_logo.png",
          width: responsive.wp(80),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
