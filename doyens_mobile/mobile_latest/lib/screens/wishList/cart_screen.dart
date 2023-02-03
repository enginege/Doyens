import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/sign_in/components/login_firebase.dart';

import '../../models/Wish.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class WishList extends StatelessWidget {
  static String routeName = "/wish";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Wishlist",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${wishList == null ? 0 : wishList!.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
