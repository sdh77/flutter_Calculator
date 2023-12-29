import 'package:calculator/screen/calculator.dart';
import 'package:flutter/material.dart';

class KeyPad extends StatefulWidget {
  final Color bgColor;
  final String keyPadText;
  final bool isZero;

  const KeyPad({
    super.key,
    required this.bgColor,
    required this.keyPadText,
    required this.isZero,
  });

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
  void touchPad(String keyPadText) {
    setState(() {
      calc.changeValue(context)?.string = keyPadText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: widget.isZero ? 2 : 1,
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () {
          touchPad(widget.keyPadText);
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.bgColor,
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          alignment: Alignment.center,
          height: double.infinity,
          child: Text(
            widget.keyPadText,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
