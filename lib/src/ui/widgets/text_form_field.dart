import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackaton_flutter/src/utils/responsive.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final bool obscureText, readOnly;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final Color? iconColor;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool useLabel;
  final VoidCallback? actionIcon;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final Function? onEditingComplete;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final bool useSuffixIcon;
  final Color? borderColor;
  final TextAlign? textAlign;
  final Color? fillColor;
  final bool? autoFocus;
  final TextStyle? textStyle;
  final int? maxLines;
  final void Function(String)? onChanged;
  final EdgeInsets? padding;

  const TextFormFieldWidget(
      {Key? key,
      this.hintText,
      this.obscureText = false,
      this.readOnly = false,
      this.controller,
      this.suffixIcon,
      this.iconColor,
      this.textInputType,
      this.maxLength,
      this.useLabel = false,
      this.actionIcon,
      this.onTap,
      this.focusNode,
      this.onEditingComplete,
      this.textInputAction,
      this.inputFormatters,
      this.textCapitalization = TextCapitalization.none,
      this.validator,
      this.useSuffixIcon = true,
      this.borderColor,
      this.textAlign,
      this.fillColor,
      this.autoFocus,
      this.textStyle,
      this.maxLines,
      this.onChanged,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return TextFormField(
      autofocus: autoFocus ?? false,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      textAlign: textAlign ?? TextAlign.start,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      style: textStyle ??
          Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w500,
              color: borderColor ?? Colors.grey,
              fontSize: responsive.dp(1.5)),
      maxLength: maxLength,
      focusNode: focusNode,
      controller: controller,
      cursorColor: borderColor ?? Colors.grey,
      inputFormatters: inputFormatters,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: padding ??
              EdgeInsets.only(
                  left: textAlign != null ? 0 : responsive.wp(4),
                  top: responsive.hp(2.2),
                  bottom: responsive.hp(2.2)),
          counterText: "",
          hintText: hintText,
          hintStyle: textStyle ??
              Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.grey, fontSize: responsive.dp(1.5)),
          suffixIcon: useSuffixIcon
              ? IconButton(
                  icon: Icon(suffixIcon,
                      color: iconColor ?? Theme.of(context).iconTheme.color),
                  onPressed: actionIcon)
              : null,
          fillColor: fillColor ?? Colors.white,
          filled: true,
          errorStyle: Theme.of(context).textTheme.headline6!.copyWith(
              fontSize: responsive.dp(1.5),
              color: borderColor ?? Colors.red,
              fontWeight: FontWeight.bold),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: borderColor ?? Colors.red, width: 1)),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: borderColor ?? Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(width: 1, color: borderColor ?? Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
                BorderSide(width: 1, color: borderColor ?? Colors.white),
          )),
    );
  }
}
