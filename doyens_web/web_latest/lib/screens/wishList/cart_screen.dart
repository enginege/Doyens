import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar_wish.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/size_config.dart';

import '../../enums.dart';
import '../../models/Wish.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class WishList extends StatelessWidget {
  static String routeName = "/wish";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, getProportionateScreenWidth(15)),
        child: CustomBottomNavBar_Wish(selectedMenu: MenuState.favourite),
      ),
      body: Body(),
      // bottomNavigationBar: CheckoutCard(),
    );
  }
}
