
import 'package:flutter/material.dart';

class CommonButton extends StatefulWidget {
  const CommonButton({super.key, required this.onTap, required this.text, this.color, this.textColor});

  final Function() onTap;
  final String text;
  final Color? color;
  final Color? textColor;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: widget.color ?? Theme.of(context).colorScheme.secondary,
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2
          )
        ),
        child: Text(widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: widget.textColor ?? Colors.white,
            fontSize: 19.0
          )
        ),
      ),
    );
  }
}