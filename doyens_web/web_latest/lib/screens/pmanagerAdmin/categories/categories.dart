import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/pmanagerAdmin/products/add_product.dart';
import 'package:shop_app/screens/pmanagerAdmin/categories/components/body.dart'
    as pbody;

class CategoriesScreen extends StatelessWidget {
  static String routeName = "/pmanagercategories";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: pbody.Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text(
              "Categories",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${productListnew.length} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ]),
        ],
      ),
    );
  }
}
