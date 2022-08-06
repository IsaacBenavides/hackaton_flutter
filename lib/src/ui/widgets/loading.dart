import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';
import 'package:lottie/lottie.dart';

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Lottie.asset("assets/animations/loading.json",
              width: responsive.wp(40)),
        ),
      ),
    );
  }
}

openLoader(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => _Loading(),
      useRootNavigator: true,
      barrierDismissible: false);
}

closeLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
