import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({Key? key, required this.press, required this.colour, required this.isclicked})
      : super(key: key);
  final Function() press;
  final Color colour;
  final bool isclicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.height * 0.04,
        decoration: BoxDecoration(
            border: isclicked
                ? Border.all(color: Color.fromARGB(255, 92, 216, 232), width: 3)
                : Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: colour),
      ),
    );
  }
}
