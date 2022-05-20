import 'package:cached_network_image/cached_network_image.dart';
import 'package:demoecommerce/BusinessLogic/category/cubit/category_cubit.dart';
import 'package:demoecommerce/screens/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categories extends StatelessWidget {
  Categories(this.tabcontroller);
  final tabcontroller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
              title: 'Browse Categories',
              press: () {
                tabcontroller.animateTo(1);
              }),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (BuildContext context, state) {
            if (state is CategoryLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CategoryLoaded) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: state.snap.size,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryCard(
                          icon: state.snap.docs[index].get('img'),
                          text: state.snap.docs[index].get('category'),
                          press: () {
                            Navigator.pushNamed(context, '/subcategory',
                                arguments: state.snap.docs[index]);
                          });
                    }),
              );
            } else {
              return Text('Something went wrong');
            }
          }),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                      imageUrl: icon,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => ColoredBox(
                                color: Colors.black12,
                              ),
                      errorWidget: (context, url, error) => Icon(Icons.error))),
              SizedBox(height: 5),
              Text(text, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
