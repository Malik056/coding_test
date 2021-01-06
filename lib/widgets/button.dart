import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double padding;
  final ShapeBorder border;
  final double borderRadius;
  final Color color;
  final Color textColor;
  final String text;
  final TextStyle textStyle;
  final Function() onPressed;

  const MyButton(
      {Key key,
      this.width,
      this.padding,
      this.border,
      this.borderRadius,
      this.color,
      @required this.text,
      this.onPressed,
      this.textStyle,
      this.textColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    assert(border == null || (border != null && borderRadius == null),
        "parameter border should be null if borderRadius is provided");
    assert(textStyle == null || (textStyle != null && textColor == null),
        "[textColor] should be null if textStyle is provided");
    return Container(
      height: 50,
      width: width ?? MediaQuery.of(context).size.width,
      child: RaisedButton(
        padding: EdgeInsets.all(padding ?? 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
        ),
        color: color ?? Theme.of(context).primaryColor,
        child: Text(
          '$text',
          style: textStyle ??
              Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: textColor ?? Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
