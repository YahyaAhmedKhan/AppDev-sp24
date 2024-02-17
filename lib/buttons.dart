import 'package:flutter/material.dart';

abstract class GeneralButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final ButtonStyle? style;
  final Alignment? alignment;

  const GeneralButton({
    required this.label,
    required this.onPressed,
    this.style,
    this.alignment,
  }) : super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class NumberButton extends GeneralButton {
  const NumberButton({
    required String label,
    required void Function() onPressed,
    ButtonStyle? style,
    Alignment? alignment,
  }) : super(
            label: label,
            onPressed: onPressed,
            style: style,
            alignment: alignment);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * 0.75 / 4;
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(
              fontFamily: "SFNSDisplay",
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 39,
            ),
            fixedSize: Size(size, size),
          ),
      child: Align(
        alignment: alignment ?? Alignment.topCenter,
        child: Text(
          style: const TextStyle(
            height: 1.05,
          ),
          label,
          textAlign: TextAlign.center,

          // style: TextStyle(
          //   height:
          //       1, // Adjusts the line-height, potentially useful for centering
          // ),
        ),
      ),
    );
  }
}

class ExtraButton extends GeneralButton {
  const ExtraButton({
    required String label,
    required void Function() onPressed,
    ButtonStyle? style,
  }) : super(label: label, onPressed: onPressed, style: style);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * 0.75 / 4;

    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade400,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            // textStyle: const TextStyle(
            //   color: Colors.black,
            //   fontSize: 28,
            // ),
            fixedSize: Size(size, size),
          ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: const TextStyle(
              fontFamily: "SFNSDisplay",
              color: Colors.black54,
              fontWeight: FontWeight.w700,
              fontSize: 29),
        ),
      ),
    );
  }
}

class OpButton extends GeneralButton {
  const OpButton({
    required String label,
    required void Function() onPressed,
    ButtonStyle? style,
  }) : super(label: label, onPressed: onPressed, style: style);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * 0.75 / 4;
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            textStyle: const TextStyle(
              height: 0.89,
              fontFamily: "SFNSDisplay",
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 45,
            ),
            fixedSize: Size(size, size),
          ),
      child: Text(label),
    );
  }
}
