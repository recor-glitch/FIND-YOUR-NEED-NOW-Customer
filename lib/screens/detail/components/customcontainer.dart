import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {Key? key, required this.press, required this.value, required this.colour, required this.style, required this.border})
      : super(key: key);
  final Function() press;
  final String value;
  final Color colour;
  final TextStyle style;
  final BorderSide border;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              onPressed: press,
              child: Text(value, style: style),
              style: ElevatedButton.styleFrom(primary: colour, side: border))),
    );
  }
}
