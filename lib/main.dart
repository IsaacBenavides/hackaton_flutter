import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hackaton_flutter/src/ui/routes/routes.dart';
import 'package:hackaton_flutter/src/ui/routes/routes_name.dart';
import 'package:hackaton_flutter/src/utils/dependecy_injector.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS || Platform.isAndroid) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: DependencyInjector.injector(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.4)),
            child: child!);
      },
      title: 'Hackaton',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CustomRoutes.routes,
      initialRoute: RoutesName.splashPage,
    );
  }
}
