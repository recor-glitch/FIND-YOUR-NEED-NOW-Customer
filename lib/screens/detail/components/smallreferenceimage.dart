import 'package:flutter/material.dart';

class smallReferenceImage extends StatelessWidget {
  const smallReferenceImage({Key? key, required this.press, required this.asset, required this.isclicked})
      : super(key: key);
  final String asset;
  final Function() press;
  final bool isclicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedContainer(
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(5),
          duration: Duration(milliseconds: 100),
          child: Image.network(asset),
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: isclicked
                ? Border.all(color: Color.fromARGB(255, 92, 216, 232), width: 2)
                : Border.all(color: Colors.grey.shade300, width: 2),
          )),
    );
  }
}
