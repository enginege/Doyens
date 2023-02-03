import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/comment/pending_comments.dart';
import 'package:shop_app/screens/home/components/categories.dart';
import 'package:shop_app/screens/pmanagerAdmin/categories/categories.dart';
import 'package:shop_app/screens/pmanagerAdmin/deliveries.dart';
import 'package:shop_app/screens/pmanagerAdmin/products/components/stock_body.dart';
import 'package:shop_app/screens/pmanagerAdmin/products/products.dart';
import 'package:shop_app/screens/pmanagerAdmin/products/products_stock.dart';
import '../../../screens/profile/components/profile_menu.dart';
import '../sales_manager/orders/transactions_all.dart';
import 'deliveries/transactions_all.dart';

class ProductManagerAdminScreen extends StatelessWidget {
  static String routeName = "/pmanagerpanel";
  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App Name'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductsScreen()));
                    },
                    child: Text(
                      "Products",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DeliveriesScreen()));
                    },
                    child: Text(
                      "Deliveries",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => pendingCommentsScreen()));
                    },
                    child: Text(
                      "Comments",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ))
              ]),
        ));
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App Name'),
        ),
        body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          //ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Add Category",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoriesScreen()));
                 /* Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => pendingCommentsScreen()));*/
            },
          ),
          ProfileMenu(
            text: "Add/Remove Product",
            icon: "assets/icons/User Icon.svg",
            press: () {
               Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductsScreen()));
            },
          ),
          ProfileMenu(
            text: "Stock Management",
            icon: "assets/icons/Settings.svg",
            press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StockProductsScreen()));
            },
          ),
          ProfileMenu(
            text: "All invoices",
            icon: "assets/icons/box.svg",
            press: () {
             Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllTransactionsScreen()));
            },
          ),   
          ProfileMenu(
            text: "Deliveries",
            icon: "assets/icons/box.svg",
            press: () {
             Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllTransactionsScreen2()));
            },
          ),    
              ProfileMenu(
                text: "Approve Comments",
                icon: "assets/icons/Settings.svg",
                press: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => pendingCommentsScreen()));
                },
              ),
            ],
          ),
        ));
  }
}
