import 'package:flutter/material.dart';

class SquaredButton extends StatefulWidget {
  final double size;
  final double borderWidth;
  final String character;
  final void Function()? onPressed;

  const SquaredButton({
    Key? key,
    this.size = 28.0,
    this.borderWidth = 1.0,
    required this.character,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SquaredButton> createState() => _SquaredButtonState();
}

class _SquaredButtonState extends State<SquaredButton> {
  @override
  Widget build(BuildContext context) {
    final String character = widget.character;
    final double size = widget.size;
    final double borderWidth = widget.borderWidth;
    final void Function()? onPressed = widget.onPressed;

    return Material(
      shape: const BeveledRectangleBorder(),
      child: Ink(
        child: SizedBox(
          width: size,
          height: size,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(width: borderWidth, color: Colors.black12),
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black38,
              ),
              onPressed: onPressed,
              child: FittedBox(
                child: Text(
                  character,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: size,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
