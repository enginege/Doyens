import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/wishList/cart_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:path/path.dart';
import '../constants.dart';
import '../enums.dart';
import '../screens/cart/cart_screen.dart';
import '../screens/sign_in/components/login_firebase.dart';
import '../screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/size_config.dart';

//Should make this widget StatefulWidget !!!!  Cart Amount is Bugged
class CustomBottomNavBar_Cart extends StatelessWidget {
  const CustomBottomNavBar_Cart({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color.fromARGB(255, 0, 0, 0);
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: BoxDecoration(
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
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Shop Icon.svg",
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  //iconSize: MenuState.home == selectedMenu ? 15 : 20,

                  onPressed: () => {
                        if (MenuState.home == selectedMenu)
                          {}
                        else
                          {
                            Navigator.pushNamed(context, HomeScreen.routeName),
                          }
                      }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Heart Icon.svg",
                    color: MenuState.favourite == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WishList()))),
              Row(
                children: [
                  Text(
                    "Your Cart",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  //Text(
                  //  "${currentCart.cartItems!.length} items",
                  //  style: TextStyle(fontSize: 20, color: kPrimaryColor),
                  //),
                ],
              ),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/Cart Icon.svg",
                    color: MenuState.cart == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: () => {
                        if (MenuState.cart == selectedMenu)
                          {}
                        else
                          {
                            Navigator.pushNamed(context, CartScreen.routeName),
                          }
                      }),
              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/User Icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  //iconSize: MenuState.profile == selectedMenu ? 15 : 20,
                  onPressed: () {
                    if (loginStatus == true) {
                      if (MenuState.profile == selectedMenu) {
                      } else {
                        Navigator.pushNamed(context, ProfileScreen.routeName);
                      }
                    } else {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    }
                  }),
            ],
          )),
    );
  }
}
