import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/categories/category_whey.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/search_results.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

List<Product> searchList = [];

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newvalue;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
        padding: EdgeInsets.only(right: getProportionateScreenWidth(25)),
        child: CircleAvatar(
          radius: getProportionateScreenWidth(12),
          backgroundImage: AssetImage("assets/images/appimage.png"),
        ),
      ),
      Container(
        width: SizeConfig.screenWidth * 0.4,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          onSubmitted: (value) => {
            searchList.clear(),
            newvalue = value.toLowerCase(),
            for (var key in productListnew)
              {
                if (key.title.toLowerCase().contains(newvalue) ||
                    key.description.toLowerCase().contains(newvalue))
                  {searchList.add(key)},
              },
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SearchResults()))
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                  vertical: getProportionateScreenWidth(4)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Search product",
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    ]);
  }
}
