/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFiledSubmitted;

  const RoundedInputField({
    Key? key,
    this.hintText,
    this.labelText,
    this.icon,
    this.autoFocus = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onFiledSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFiledSubmitted ?? (() {})(),
      autofocus: autoFocus,
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        /*floatingLabelBehavior: FloatingLabelBehavior.always,*/
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        focusColor: Theme.of(context).focusColor,
        hintStyle: TextStyle(
          color: Theme.of(context).focusColor,
        ),
/*        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).focusColor,
          ),
        ),*/
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 20),
          child: icon == null ? null : Icon(
            icon,
          ),
        ),
        hintText: hintText,
      ),
    );
  }
}
