import 'package:assignment/src/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ButtonWidgets extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;

  const ButtonWidgets({
    super.key,
    required this.btnName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: ColorConstants.primary,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Text(
          btnName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorConstants.white,
          ),
        ),
      ),
    );
  }
}
