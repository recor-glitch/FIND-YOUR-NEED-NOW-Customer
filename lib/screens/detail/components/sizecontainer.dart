import 'package:flutter/material.dart';

class SizeContainer extends StatelessWidget {
  const SizeContainer(
      {Key? key, required this.size, required this.press, required this.isclicked})
      : super(key: key);
  final String size;
  final Function() press;
  final bool isclicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
          margin:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Colors.grey.shade200,
              border: isclicked
                ? Border.all(color: Color.fromARGB(255, 92, 216, 232), width: 3)
                : Border.all(color: Colors.grey.shade300, width: 2)),
          child: Center(child: Text(size))),
    );
  }
}
