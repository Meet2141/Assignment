import 'package:assignment/src/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidgets extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validate;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final bool? obscureText;

  const TextFieldWidgets({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChange,
    required this.validate,
    this.textInputAction,
    this.inputFormatter,
    this.keyboardType,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChange,
      validator: validate,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      inputFormatters: inputFormatter,
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 100),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        alignLabelWithHint: true,
        filled: true,
        isDense: true,
        fillColor: ColorConstants.white,
        labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
        hintStyle: const TextStyle(fontSize: 12, color: Colors.black),
        errorStyle: const TextStyle(fontSize: 10, color: Colors.red, height: 0.3),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 12, top: 12.0, right: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.primary, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.transparent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.transparent, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
