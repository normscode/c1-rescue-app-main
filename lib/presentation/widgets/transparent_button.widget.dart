
import 'package:flutter/material.dart';

class TransparentButton extends StatefulWidget {
  const TransparentButton({super.key, required this.onTap, required this.text});

  final Function() onTap;
  final String text;

  @override
  State<TransparentButton> createState() => _TransparentButtonState();
}

class _TransparentButtonState extends State<TransparentButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(3)
        ),
        child: Text(widget.text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 19.0
          )
        ),
      ),
    );
  }
}