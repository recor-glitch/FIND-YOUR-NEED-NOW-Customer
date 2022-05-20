import 'package:demoecommerce/models/product.dart';
import 'package:flutter/material.dart';

class SingleGridRow extends StatelessWidget {
  const SingleGridRow(
      {Key? key,
      required this.height,
      required this.product1,
      required this.product2})
      : super(key: key);
  final double height;
  final Product product1, product2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ProductCard3(product: product1)),
          Expanded(child: ProductCard3(product: product2))
        ],
      ),
    );
  }
}

class ProductCard3 extends StatefulWidget {
  const ProductCard3({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductCard3> createState() => _ProductCard3State();
}

class _ProductCard3State extends State<ProductCard3> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            Expanded(child: Image(image: AssetImage(widget.product.image))),
            Text(widget.product.name)
          ],
        ));
  }
}
