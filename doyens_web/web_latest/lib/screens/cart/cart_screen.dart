import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/size_config.dart';
import '../../enums.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar_cart.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, getProportionateScreenWidth(25)),
        child: CustomBottomNavBar_Cart(selectedMenu: MenuState.cart),
      ),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Color.fromARGB(255, 214, 210, 210),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 12,
            spreadRadius: 10,
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            //Text(
            //  "${currentCart.cartItems!.length} items",
            //  style: Theme.of(context).textTheme.caption,
            //),
          ],
        ),
      ),
    );
  }
}
