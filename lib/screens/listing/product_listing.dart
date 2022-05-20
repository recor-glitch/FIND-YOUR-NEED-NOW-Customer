import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoecommerce/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';

class ProductListing extends StatelessWidget {
  const ProductListing({Key? key, required this.products}) : super(key: key);
  final List products;

  @override
  Widget build(BuildContext context) {
    Widget CustomProductCard(int index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/productdetail',
              arguments: products[index]);
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: CachedNetworkImage(
                        imageUrl: products[index]['Images'][0])),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(products[index]['Description'],
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        Text('₹ ${products[index]['Price']}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('In stock', style: TextStyle(color: Colors.green)),
                        Text(products[index]['Brand'])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: HomeHeader(isback: true, maincontext: context),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductCard(index);
                })
          ]),
        ),
      ),
    );
  }
}
