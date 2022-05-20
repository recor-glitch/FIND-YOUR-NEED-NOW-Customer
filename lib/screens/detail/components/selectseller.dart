import 'package:flutter/material.dart';

class SelectSeller extends StatelessWidget {
  const SelectSeller({Key? key, required this.press}) : super(key: key);
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Seller', style: TextStyle(fontSize: 20)),
            Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}
