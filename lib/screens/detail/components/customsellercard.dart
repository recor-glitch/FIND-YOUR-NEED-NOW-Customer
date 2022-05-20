import 'package:flutter/material.dart';

class CustomSellerCard extends StatelessWidget {
  const CustomSellerCard({Key? key, required this.price, required this.seller}) : super(key: key);
  final String price, seller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('₹ $price', style: TextStyle(fontSize: 20)),
        subtitle: Text('Offer from $seller'),
        trailing: ElevatedButton(
            onPressed: () {},
            child: Text('Add to Cart'),
            style: ElevatedButton.styleFrom(primary: Colors.yellow)));
  }
}
