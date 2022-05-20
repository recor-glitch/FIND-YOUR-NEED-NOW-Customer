import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/Components/product_card.dart';
import 'package:demoecommerce/models/product.dart';
import 'package:demoecommerce/screens/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Banner3 extends StatelessWidget {
  const Banner3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(title: 'Banner 3', press: () {}),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                var data =
                    state.snap.docs[3].get('Sub_Category')['Mobile'] as List;
                return GridView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, '/productdetail', arguments: data[index]);
                        }),
                        child: ProductCard2(
                            product: Product(
                                image: data[index]['Images'][0],
                                price: double.parse(data[index]['Price']),
                                description: data[index]['Description'],
                                name: data[index]['Name'])),
                      );
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ],
    );
  }
}
