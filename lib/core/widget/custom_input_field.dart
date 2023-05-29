import 'package:flutter/material.dart';
import 'package:flutter_application_sidorma/core/resources/fonts.dart';

class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? textEditingController;

  final String? Function(String?) validator;
  final bool suffixIcon;
  final bool? isDense;
  final bool obscureText;

  const CustomInputField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.validator,
      this.textEditingController,
      this.suffixIcon = false,
      this.isDense,
      this.obscureText = false})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: FontsGlobal.semiBoldTextStyle12),
          ),
          TextFormField(
            controller: widget.textEditingController,
            obscureText: (widget.obscureText && _obscureText),
            style: FontsGlobal.mediumTextStyle14,
            decoration: InputDecoration(
              isDense: (widget.isDense != null) ? widget.isDense : false,
              hintText: widget.hintText,
              hintStyle: FontsGlobal.lightTextStyle12,
              suffixIcon: widget.suffixIcon
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.remove_red_eye : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(maxHeight: 33) : null,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
