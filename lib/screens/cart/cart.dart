import 'package:demoecommerce/models/productmodel.dart';
import 'package:demoecommerce/screens/cart/components/body.dart';
import 'package:demoecommerce/screens/home/components/home_header.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  Cart({Key? key, required this.controller}) : super(key: key);
  final TabController controller;

  CartProductModel model1 = CartProductModel(
      sizes: [],
      colours: [
        {'r': 255, 'g': 255, 'b': 255},
        {'r': 20, 'g': 20, 'b': 20}
      ],
      price: '68999.00',
      name: 'ASUS TUF Dash F15',
      quantity: 1,
      size: null,
      colour: {'r': 255, 'g': 255, 'b': 255},
      img: [
        'https://m.media-amazon.com/images/I/71aVAQCGn0S._SX679_.jpg',
        'https://m.media-amazon.com/images/I/71xtEI+3ICL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/71xOtSqrd3S._SX679_.jpg',
        'https://m.media-amazon.com/images/I/71-s1USWUGS._SX679_.jpg'
      ],
      desc:
          'ASUS TUF Dash F15 (2021) 15.6 inches FHD 144Hz, Intel Core i5-11300H 11th Gen Gaming Laptop, RTX 3050 4GB Graphics (8GB RAM/512GB SSD/Windows 10/White/2Kg), FX516PC-HN057T',
      brand: 'ASUS');

  CartProductModel model2 = CartProductModel(
      sizes: [],
      colours: [
        {'r': 255, 'g': 255, 'b': 255},
        {'r': 20, 'g': 20, 'b': 20}
      ],
      price: '6599.00',
      quantity: 1,
      name: 'Tecno Pop 5',
      img: [
        'https://m.media-amazon.com/images/I/81fPFHIBoQL._SY741_.jpg',
        'https://m.media-amazon.com/images/I/71aDVqSTAZL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/71lFXn4bAzL._SY741_.jpg',
        'https://m.media-amazon.com/images/I/81ikixf0AxL._SY741_.jpg'
      ],
      desc:
          'Tecno Pop 5 LTE(Turquoise Cyan 2G+32GB)| 6.52" HD+Dot Notch | 5000mAh | 8MP Dual Camera | Front Flash| IPX2 Splash Resistant',
      brand: 'Techno',
      size: null,
      colour: {'r': 255, 'g': 255, 'b': 255});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
          child: HomeHeader(isback: true, maincontext: context, press: () => controller.animateTo(0)),
        ),
        backgroundColor: Colors.grey.shade200,
        body: Body(products: [model1, model2]),
      ),
    );
  }
}
