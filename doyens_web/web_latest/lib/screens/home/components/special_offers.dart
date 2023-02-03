import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/categories/category_default.dart';
import 'package:shop_app/screens/categories/category_pre.dart';
import 'package:shop_app/screens/home/components/body.dart';

import '../../../size_config.dart';
import '../../categories/category_whey.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Categories",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        Container(
            child: FutureBuilder(
          future: getCategories(),
          builder: (context, AsyncSnapshot<List<String>> snap) {
            if (snap.connectionState == ConnectionState.none &&
                snap.hasData == null) {
              return Container();
            }
            return Container(
              child: Wrap(
                  direction: Axis.horizontal,
                  children: snap.data!
                      .map((value) => Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(10),
                                right: getProportionateScreenWidth(10),
                                bottom: getProportionateScreenWidth(10)),
                            child: SpecialOfferCard(
                              image:
                                  "https://blog.bodyforumtr.com/wp-content/uploads/2020/07/250tldenazproteintozu.jpg",
                              category: value,
                              numOfBrands: 0,
                              press: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        DefaultCategoryScreen(
                                          categoryName: value,
                                          products: getProductswCat(value),
                                        )));
                              },
                            ),
                          ))
                      .toList()),
            );
          },
        )),
      ],
    );
  }

  Future<List<String>> getCategories() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();
    ;

    // Get data from docs and convert map to Lis
    //for a specific field

    return querySnapshot.docs.map((doc) => doc.get('name') as String).toList();
  }

  List<Product> getProductswCat(String str) {
    List<Product> prds = [];
    for (var task in productListnew) {
      // do something
      if (task.category == str) {
        prds.add(task);
      }
    }
    return prds;
  }
}

/*


 Row(
            children: [
              SpecialOfferCard(
                image:
                    "https://blog.bodyforumtr.com/wp-content/uploads/2020/07/250tldenazproteintozu.jpg",
                category: "Protein Tozları",
                numOfBrands: 18,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WheyScreen()));
                },
              ),
              SpecialOfferCard(
                image:
                    "https://4fpnph3j8bls2w9fqo3k4xd5-wpengine.netdna-ssl.com/wp-content/uploads/2022/01/27812728_web1_M1-FWM-20220112-Best-PreWorkout-1280.jpeg",
                category: "Preworkoutlar",
                numOfBrands: 24,
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PreScreen()));
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
 */

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(10)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(110),
          height: getProportionateScreenWidth(50),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(image, fit: BoxFit.fill),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //TextSpan(text: "$numOfBrands Brands")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
