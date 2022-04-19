import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, size: 30),
            onPressed: () {
              controller.animateTo(0);
            },
          ),
          IconButton(
            icon: Icon(Icons.list, size: 30),
            onPressed: () {
              controller.animateTo(1);
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, size: 30),
            onPressed: () {
              controller.animateTo(2);
            },
          ),
          IconButton(
            icon: Icon(Icons.person, size: 30),
            onPressed: () {
              controller.animateTo(3);
            },
          )
        ],
      ),
    );
  }
}
