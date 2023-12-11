import 'package:flutter/material.dart';

import '../../../core/utils/extensions.dart';

class CustomAuthField extends StatelessWidget {
  final String hintText;
  final String? prefixIcon;
  final String? suffixText;
  final VoidCallback? onSuffixTap;
  final TextInputAction textInputAction;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomAuthField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.onSuffixTap,
    this.suffixText,
    this.textInputAction = TextInputAction.next,
    this.onSaved,
    this.onTap,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      onSaved: onSaved,
      validator: validator,
      // enabled: false,
      readOnly: true,
      onTap: onTap,
      decoration: CustomInputDecoration.decorate(
        hintText: hintText,
        prefixIcon: prefixIcon,
        onSuffixTap: onSuffixTap,
        suffixText: suffixText,
      ),
    );
  }
}
