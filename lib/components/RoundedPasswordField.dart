/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  //const RoundedPasswordField({Key key}) : super(key: key);
  final String? hintText;
  final String? labelText;
  final Function? press;
  final bool autoFocus;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFiledSubmitted;

  const RoundedPasswordField({
    Key? key,
    this.hintText,
    this.labelText,
    this.press,
    this.autoFocus = false,
    this.onChanged,
    this.validator,
    this.controller,
    this.textInputAction = TextInputAction.go,
    this.focusNode,
    this.onFiledSubmitted,
    this.icon,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    final focusScope = FocusScope.of(context);

    return TextFormField(
      onEditingComplete: () => focusScope.unfocus(),
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFiledSubmitted ?? (() {})(),
      textInputAction: widget.textInputAction,
      autofocus: widget.autoFocus,
      onChanged: widget.onChanged,
      controller: widget.controller,
      obscureText: showPassword,
      validator: widget.validator,
      decoration: InputDecoration(
        focusColor: Theme.of(context).focusColor,
        hintStyle: TextStyle(
          color: Theme.of(context).focusColor,
        ),
        /*floatingLabelBehavior: FloatingLabelBehavior.always,*/
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
/*        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 1.0,
            color: Theme.of(context).focusColor,
          ),
        ),*/
        border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30),
          ),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        //contentPadding: EdgeInsets.all(5),
        hintText: widget.hintText,
        icon: widget.icon == null
            ? null
            : Icon(
                widget.icon,
              ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () => setState(() => showPassword = !showPassword),
            icon: Icon(Icons.visibility),
          ),
        ),
        labelText: widget.labelText,
      ),
    );
  }
}
