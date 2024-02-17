import 'package:flutter/material.dart';

abstract class GeneralButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final ButtonStyle? style;

  const GeneralButton({
    required this.label,
    required this.onPressed,
    this.style,
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
  }) : super(label: label, onPressed: onPressed, style: style);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double size = screenWidth * 0.75 / 4;
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade800,
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            textStyle: const TextStyle(
              fontFamily: "SFNSDisplay",
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 35,
            ),
            fixedSize: Size(size, size),
          ),
      child: Text(label),
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
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            // textStyle: const TextStyle(
            //   color: Colors.black,
            //   fontSize: 28,
            // ),
            fixedSize: Size(size, size),
          ),
      child: SizedBox(
        child: Text(
          label,
          style: const TextStyle(
              fontFamily: "SFNSDisplay",
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 24),
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
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            textStyle: const TextStyle(
              fontFamily: "Helvetica",
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 30,
            ),
            fixedSize: Size(size, size),
          ),
      child: Text(label),
    );
  }
}
