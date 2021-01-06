import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final FocusNode focusNode;
  final bool autofocus;
  final TextStyle style;
  final String hint;
  final String label;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final InputDecoration decoration;
  final String helperText;
  final String Function(String) validator;
  final TextInputType inputType;
  final Icon suffix;
  final onSuffixPress;
  final Widget prefix;
  final bool obsecureText;

  const MyTextFormField({
    Key key,
    this.focusNode,
    this.autofocus,
    this.style,
    this.hint,
    this.label,
    this.hintStyle,
    this.labelStyle,
    this.decoration,
    this.validator,
    this.inputType,
    this.suffix,
    this.prefix,
    this.obsecureText,
    this.onSuffixPress,
    this.helperText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(
        (decoration != null &&
                (suffix == null &&
                    hint == null &&
                    label == null &&
                    helperText == null &&
                    hintStyle == null &&
                    labelStyle == null)) ||
            (decoration == null),
        "decoration should be null if any of the parameter [hint, label, hintStyle, labelStyle] is provided");
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        // color: Theme.of(context).primaryColor,
      ),
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
        suffixIcon: GestureDetector(
          dragStartBehavior: DragStartBehavior.down,
          onTap: onSuffixPress,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: suffix,
          ),
        ),
        // prefix: prefix,
        hintText: hint ?? '',
        labelText: label ?? '',
        helperText: helperText,
        icon: prefix,
        hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
              color: Theme.of(context).disabledColor,
            ),
      ),
      obscureText: obsecureText ?? false,
      // onChanged: (value) {
      //   setState(() {
      //     user.confirmPassword = value.trim();
      //   });
      // },
      validator: validator,
    );
  }
}
