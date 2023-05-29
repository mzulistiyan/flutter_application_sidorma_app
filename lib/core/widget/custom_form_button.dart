import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/resources/colors.dart';
import 'package:flutter_application_sidorma/core/resources/fonts.dart';

class CustomFormButton extends StatelessWidget {
  final String innerText;
  final void Function()? onPressed;
  final Color? color;
  const CustomFormButton({Key? key, required this.innerText, required this.onPressed, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color ?? ColorsGlobal.secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          innerText,
          style: FontsGlobal.semiBoldTextStyle14.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
