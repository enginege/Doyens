import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/helper/database_manager.dart';
import 'package:shop_app/models/Cart.dart';

import '../../../main.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              opacity: 1,
              fit: BoxFit.fill,
              image: AssetImage("assets/images/appimage.png"))),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 8),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 240, 240),
            borderRadius: BorderRadius.only(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                spreadRadius: 10,
                blurRadius: 12,
                offset: Offset(0, 3),
              )
            ]),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: ListView.builder(
            itemCount: currentCart.cartItems!.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Dismissible(
                key: Key(currentCart.cartItems![index].product.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  if (loginStatus == true)
                    await removeFromCartDB(
                        currentCart.cartItems!.elementAt(index).product.title);
                  currentCart.cartItems!.removeAt(index);
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      SvgPicture.asset("assets/icons/Trash.svg"),
                    ],
                  ),
                ),
                child: CartCard(cart: currentCart.cartItems![index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
