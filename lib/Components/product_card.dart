import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoecommerce/models/product.dart';
import 'package:flutter/material.dart';

class ProductCard2 extends StatelessWidget {
  const ProductCard2({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(children: [
          Expanded(child: Image(image: CachedNetworkImageProvider(product.image))),
          ListTile(
              title: Text(product.name, maxLines: 2),
              subtitle: Text(product.description, softWrap: false, maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: Text('₹ ${product.price.toString()}'))
        ]),
      ),
    );
  }
}
