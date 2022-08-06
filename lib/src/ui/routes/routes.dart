import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/ui/pages/create_offer_page.dart';
import 'package:hackaton_flutter/src/ui/pages/offer_details_page.dart';
import 'package:hackaton_flutter/src/ui/pages/offers_page.dart';
import 'package:hackaton_flutter/src/ui/pages/splash_page.dart';
import 'package:hackaton_flutter/src/ui/pages/update_offer_page.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';

class CustomRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashPage:
        return MaterialPageRoute(
            builder: (_) => const SplashPage(), settings: settings);
      case RoutesName.allOffers:
        return MaterialPageRoute(
            builder: (_) => const OffersPage(), settings: settings);
      case RoutesName.offerDetails:
        return MaterialPageRoute(
            builder: (_) => const OfferDetailsPage(), settings: settings);
      case RoutesName.offerUpdate:
        return MaterialPageRoute(
            builder: (_) => const UpdateOfferPage(), settings: settings);
      case RoutesName.offerCreate:
        return MaterialPageRoute(
            builder: (_) => const CreateOfferPage(), settings: settings);
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
