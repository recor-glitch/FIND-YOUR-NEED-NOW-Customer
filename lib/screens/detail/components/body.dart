import 'package:demoecommerce/BusinessLogic/cubit/image_cubit.dart';
import 'package:demoecommerce/BusinessLogic/cubit/quantity_cubit.dart';
import 'package:demoecommerce/BusinessLogic/cubit/selectcolor_cubit.dart';
import 'package:demoecommerce/BusinessLogic/cubit/selectsize_cubit.dart';
import 'package:demoecommerce/models/productmodel.dart';
import 'package:demoecommerce/screens/detail/components/colorcircle.dart';
import 'package:demoecommerce/screens/detail/components/customcontainer.dart';
import 'package:demoecommerce/screens/detail/components/customsellercard.dart';
import 'package:demoecommerce/screens/detail/components/expanddesc.dart';
import 'package:demoecommerce/screens/detail/components/quantity.dart';
import 'package:demoecommerce/screens/detail/components/selectseller.dart';
import 'package:demoecommerce/screens/detail/components/sizecontainer.dart';
import 'package:demoecommerce/screens/detail/components/smallreferenceimage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageCubit(product.img)),
        BlocProvider(create: (_) => SelectcolorCubit(product.colours)),
        BlocProvider(create: (_) => QuantityCubit())
      ],
      child: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(children: [
            BlocBuilder<ImageCubit, ImageState>(
              builder: (context, state) {
                if (state is ImageLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: Colors.transparent),
                            imageProvider: NetworkImage(state.img),
                            filterQuality: FilterQuality.high),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: product.img.length,
                            itemBuilder: (BuildContext context, int index) {
                              return smallReferenceImage(
                                  asset: product.img[index],
                                  press: () {
                                    BlocProvider.of<ImageCubit>(context)
                                        .OnImgClick(product.img[index], index);
                                  },
                                  isclicked: state.index == index);
                            },
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 5, spreadRadius: 2)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹ ${product.price}',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            product.name,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          ExpandedDesc(desc: product.desc)
                        ]),
                  ),
                  product.sizes.isNotEmpty
                      ? BlocProvider(
                          create: (context) => SelectsizeCubit(product.sizes),
                          child: Builder(builder: (context) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Divider(
                                        color: Colors.grey.shade200,
                                        indent: 20,
                                        endIndent: 20,
                                        thickness: 2),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Select Sizes:',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            child: BlocBuilder<SelectsizeCubit,
                                                SelectsizeState>(
                                              builder: (context, state) {
                                                if (state
                                                    is SelectsizeInitial) {
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          product.sizes.length,
                                                      itemBuilder: (BuildContext
                                                                  context,
                                                              int index) =>
                                                          SizeContainer(
                                                              size: product
                                                                  .sizes[index],
                                                              isclicked:
                                                                  product.sizes[index] ==
                                                                      state
                                                                          .size,
                                                              press: () => BlocProvider.of<SelectsizeCubit>(context)
                                                                  .OnSizeClick(
                                                                      product.sizes[index],
                                                                      index)));
                                                } else {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            );
                          }),
                        )
                      : Container(),
                  product.colours.isNotEmpty
                      ? BlocBuilder<SelectcolorCubit, SelectcolorState>(
                          builder: (context, colorstate) {
                            if (colorstate is SelectcolorInitial) {
                              return Column(
                                children: [
                                  Divider(
                                      color: Colors.grey.shade200,
                                      indent: 20,
                                      endIndent: 20,
                                      thickness: 2),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Select Colour:',
                                              style: TextStyle(fontSize: 20)),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: product.colours.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var colr = product
                                                    .colours[index] as Map;
                                                return ColorCircle(
                                                    colour: Color.fromRGBO(
                                                        int.parse(colr['r']),
                                                        int.parse(colr['g']),
                                                        int.parse(colr['b']),
                                                        1),
                                                    press: () {
                                                      BlocProvider.of<
                                                                  SelectcolorCubit>(
                                                              context)
                                                          .OnColorClick(
                                                              colr, index);
                                                    },
                                                    isclicked:
                                                        colorstate.colour ==
                                                            colr);
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        )
                      : Container(),
                  Divider(
                      color: Colors.grey.shade200,
                      indent: 20,
                      endIndent: 20,
                      thickness: 2),
                  Quantity(),
                  Divider(
                      color: Colors.grey.shade200,
                      indent: 20,
                      endIndent: 20,
                      thickness: 2),
                  SelectSeller(press: () async {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Wrap(
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text('New',
                                      style: TextStyle(fontSize: 20))),
                              CustomSellerCard(
                                  price: '2000', seller: 'Rajo Store'),
                              CustomSellerCard(
                                  price: '1599', seller: 'Sarathi Store')
                            ],
                          );
                        });
                  }),
                  Divider(
                      color: Colors.grey.shade200,
                      indent: 20,
                      endIndent: 20,
                      thickness: 2),
                  CustomContainer(
                      press: () {},
                      value: 'Buy Now',
                      colour: Color.fromRGBO(226, 51, 72, 1),
                      style: TextStyle(),
                      border: BorderSide.none),
                  CustomContainer(
                      press: () {},
                      value: 'Add to Cart',
                      colour: Colors.white,
                      style: TextStyle(color: Color.fromRGBO(226, 51, 72, 1)),
                      border: BorderSide(
                          color: Color.fromRGBO(226, 51, 72, 1), width: 1)),
                ],
              ),
            )
          ]),
        );
      }),
    );
  }
}
