import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: 90,
        //width: getProportionateScreenWidth(20),
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50)),
        padding: EdgeInsets.symmetric(
          //horizontal: getProportionateScreenWidth(5),
          vertical: getProportionateScreenWidth(5),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF4A3298),
          borderRadius: BorderRadius.circular(15),
        ),
        child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 3,
              autoPlay: true,
              enlargeCenterPage: false,
            ),
            items: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "A Summer Surpise",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: getProportionateScreenWidth(6),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      "Cashback 20%",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Weekend Deals",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: getProportionateScreenWidth(6),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    Text(
                      "20% Discount on Preworkouts!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
