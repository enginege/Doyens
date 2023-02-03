import 'package:flutter/material.dart';
import '../../../screens/profile/components/profile_menu.dart';
import '../orders/transactions_all.dart';
import '../products/products.dart';
import '../products/products_discount.dart';
import '../refunds/pending_refunds.dart';
import '../revenue/revenues.dart';
import '../revenue/order_details_all.dart';
import '../revenue/transactions_all.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          //ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Set Prices",
            icon: "assets/icons/Parcel.svg",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProductsScreen()));
            },
          ),
          ProfileMenu(
            text: "Discount",
            icon: "assets/icons/giftIcon.svg",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProductsScreen2()));
            },
          ),
          ProfileMenu(
            text: "All Invoices",
            icon: "assets/icons/box.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AllTransactionsScreen()));
            },
          ),
          ProfileMenu(
            text: "Refund Requests",
            icon: "assets/icons/Refund.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => pendingRefundsScreen()));
            },
          ),
          ProfileMenu(
            text: "Revenue",
            icon: "assets/icons/Revenue.svg",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllTransactionsScreen3()));
            },
          ),
        ],
      ),
    );
  }
}
