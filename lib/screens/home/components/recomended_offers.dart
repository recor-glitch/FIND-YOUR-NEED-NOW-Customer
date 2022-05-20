import 'package:carousel_slider/carousel_slider.dart';
import 'package:demoecommerce/screens/home/components/section_title.dart';
import 'package:flutter/material.dart';

class RecomendedOffers extends StatelessWidget {
  const RecomendedOffers({Key? key, required this.banners}) : super(key: key);
  final List banners;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(title: "Banners 2", press: () {}),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        CarouselSlider(
            items: banners.map((banner) => CustomBanner(img: banner)).toList(),
            options: CarouselOptions(
                enableInfiniteScroll: false,
                autoPlay: true,
                enlargeCenterPage: true))
      ],
    );
  }
}

class CustomBanner extends StatefulWidget {
  const CustomBanner({Key? key, required this.img}) : super(key: key);
  final String img;

  @override
  State<CustomBanner> createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(image: AssetImage(widget.img), fit: BoxFit.cover),
      ),
    );
  }
}
