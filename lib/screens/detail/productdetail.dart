import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/models/productmodel.dart';
import 'package:demoecommerce/screens/detail/components/body.dart';
import 'package:demoecommerce/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({Key? key, required this.product}) : super(key: key);
  final Map product;

  @override
  Widget build(BuildContext context) {
    ProductModel model = ProductModel(
        sizes: product['Sizes'],
        colours: product['Colors'],
        price: product['Price'],
        name: product['Name'],
        img: product['Images'],
        desc: product['Description'],
        brand: product['Brand']);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: HomeHeader(
            isback: true,
            maincontext: context,
            press: () {
              Navigator.pushNamed(context, '/')
                  .then((result) => BlocProvider.of<CategoryCubit>(context));
            },
          ),
        ),
        body: Body(product: model),
      ),
    );
  }
}
