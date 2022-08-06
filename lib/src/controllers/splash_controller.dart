import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';

class SplashController extends ChangeNotifier {
  goToOffers(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(RoutesName.allOffers, (route) => false);
    });
  }
}
