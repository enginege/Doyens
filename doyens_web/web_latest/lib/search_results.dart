import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/screens/categories/category_whey.dart';
import 'package:shop_app/screens/home/components/search_field.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import '../components/product_card.dart';
import '../helper/database_manager.dart';
import '../models/Product.dart';
import 'components/coustom_bottom_nav_bar_search_results.dart';

class SearchResults extends StatelessWidget {
  @override
  //_SearchResultsState createState() => _SearchResultsState();
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SearchResultsState(),
    );
  }
}

class _SearchResultsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, getProportionateScreenWidth(25)),
          child: CustomBottomNavBar_Search(selectedMenu: MenuState.home),
        ),
        body: _buildListView());
  }
}

Widget _buildListView() {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            opacity: 1,
            fit: BoxFit.fill,
            image: AssetImage("assets/images/backgroundimage.png"))),
    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(47)),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 10,
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: searchList == null ? 0 : searchList.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(105)),
                child: ProductCard(product: searchList[index]));

            // return _buildRow(data[index]);
          }),
    ),
  );
}
