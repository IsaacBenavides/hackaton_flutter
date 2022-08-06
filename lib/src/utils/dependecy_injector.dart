import 'package:hackaton_flutter/src/controllers/create_offer_controller.dart';
import 'package:hackaton_flutter/src/controllers/offers_controller.dart';
import 'package:hackaton_flutter/src/controllers/splash_controller.dart';
import 'package:hackaton_flutter/src/controllers/update_offer_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DependencyInjector {
  static List<SingleChildWidget> injector() {
    return [
      ChangeNotifierProvider(create: (_) => SplashController()),
      ChangeNotifierProvider(create: (_) => OffersController()),
      ChangeNotifierProvider(create: (_) => UpdateOfferController()),
      ChangeNotifierProvider(create: (_) => CreateOfferController()),
    ];
  }
}
