import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/resources/colors.dart';
import 'package:flutter_application_sidorma/core/utils/size_config.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButton extends StatelessWidget {
  String? text;
  final Function()? onPressed;
  Color? color;

  Color? textColor;

  PrimaryButton({
    super.key,
    this.onPressed,
    this.text,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight * 0.05,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 5,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            text!,
            style: GoogleFonts.montserrat(
              color: textColor ?? ColorsGlobal.secondaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
