import 'package:demoecommerce/screens/home/components/banner3.dart';
import 'package:demoecommerce/screens/home/components/recomended_offers.dart';
import 'package:flutter/material.dart';
import 'categories.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  Body(this.tabcontroller);
  final tabcontroller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Categories(tabcontroller),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SpecialOffers(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Banner3(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            RecomendedOffers(
                banners: ['assets/Image Banner 2.jpg', 'assets/discount.jpg']),
          ],
        ),
      ),
    );
  }
}
