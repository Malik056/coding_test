import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final String label;
  final void Function(int) onChanged;
  final Color activeColor;
  final Color labelColor;

  const RadioButton(
      {Key key,
      @required this.value,
      @required this.groupValue,
      @required this.label,
      @required this.onChanged,
      this.activeColor,
      this.labelColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          groupValue: groupValue,
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
        ),
        SizedBox(width: 5),
        Text(
          label ?? '',
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: labelColor ?? Colors.black,
              ),
        ),
      ],
    );
  }
}
