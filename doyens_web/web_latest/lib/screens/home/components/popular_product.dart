import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final Future<QuerySnapshot<Map<String, dynamic>>> _usersStream =
      FirebaseFirestore.instance.collection('products_new').get();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SectionTitle(title: "Popular Products", press: () {}),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenHeight(45)),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Wrap(
              children: [
                ...List.generate(
                  productListnew.length,
                  (index) {
                    if (productListnew[index].isPopular)
                      return ProductCard(product: productListnew[index]);

                    return SizedBox
                        .shrink(); // here by default width and height is 0
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
