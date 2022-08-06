import 'package:flutter/material.dart';
import 'package:hackaton_flutter/src/ui/widgets/custom_text.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  const AppBarCustom(
      {Key? key,
      required this.titleText,
      this.useBackButton = true,
      this.actions})
      : super(key: key);
  final String titleText;
  final bool useBackButton;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return AppBar(
      title: CustomText(
        text: titleText,
        fontWeight: FontWeight.bold,
        fontSize: responsive.dp(2),
        color: Colors.black,
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: useBackButton,
      leading: useBackButton ? const BackButton(color: Colors.black) : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size(0, kToolbarHeight);
}
