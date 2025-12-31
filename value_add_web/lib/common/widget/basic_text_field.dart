import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../assets/app_theme.dart';

final class BasicTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final FocusNode node;
  final ValueChanged<String>? onSubmitted;
  final TextInputFormatter? inputFormatter;

  BasicTextField({
    super.key,
    this.controller,
    this.textStyle,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconConstraints,
    FocusNode? focusNode,
    this.onSubmitted,
    this.inputFormatter,
  }) : node = focusNode ?? FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
        color: AppTheme.current.colors.blue2,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: TextField(
          focusNode: node,
          controller: controller,
          inputFormatters: [inputFormatter].whereType<TextInputFormatter>().toList(),
          decoration: _decoration(),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: textStyle,
          autofocus: false,
          obscureText: obscureText,
          cursorColor: AppTheme.current.colors.black,
          onTap: () => FocusScope.of(context).requestFocus(node),
          onSubmitted: (String value) {
            FocusScope.of(context).unfocus();
            onSubmitted?.call(value);
          },
        ),
      ),
    );
  }

  InputDecoration _decoration() {
    TextStyle hintStyle = TextStyle(color: AppTheme.current.colors.textFieldHint);
    InputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 0,
          color: Colors.transparent,
        ));
    Widget? prefixIcon;
    BoxConstraints? prefixIconConstraints;
    if (this.prefixIcon != null) {
      prefixIcon = Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
        child: this.prefixIcon,
      );
      prefixIconConstraints = const BoxConstraints(maxHeight: double.infinity);
    }
    final double leftPadding = prefixIcon == null ? 20 : 0;
    final double rightPadding = suffixIcon == null ? 20 : 0;
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle,
      prefixIcon: prefixIcon,
      prefixIconConstraints: prefixIconConstraints,
      suffixIcon: suffixIcon,
      suffixIconConstraints: suffixIconConstraints,
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(leftPadding, 0, rightPadding, 0),
      fillColor: Colors.transparent,
      filled: true,
      border: border,
      enabledBorder: border,
      focusedBorder: border,
    );
  }
}
