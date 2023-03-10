import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/database_manager.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/models/Wish.dart';
import 'package:shop_app/screens/comment/reviews.dart';
import 'package:shop_app/screens/sign_in/components/login_firebase.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/models/Cart.dart';
import '../../../main.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'item_counter.dart';

int maxlim = 0;

class Body extends StatelessWidget {
  final Product product;
  int numOfItemToAdd = 0;
  int numOfItemToAddWish = 0;
  bool found = false;
  bool problem = false;
  int count = 0;
  Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
          color: Colors.white10,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Colors.white10,
                child: Column(
                  children: [
                    NumericStepButton(
                      minValue: 0,
                      maxValue: 5,
                      onChanged: (value) {
                        numOfItemToAdd = value;
                      },
                    ),
                    TopRoundedContainer(
                      color: Colors.white10,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                          ),
                          child: Column(children: [
                            DefaultButton(
                              text: "Add To Cart",
                              press: () async {
                                await FirebaseFirestore.instance
                                    .collection("products_new")
                                    .doc(product.title)
                                    .get()
                                    .then((gelenveri) {
                                  product.stock = gelenveri.data()!["stock"];
                                });
                                problem = false;
                                if (product.stock == 0) {
                                  problem = true;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "There is no item left in the Stock",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: kPrimaryColor,
                                  ));
                                } else if (numOfItemToAdd == 0) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Please increase the amount of items!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: kPrimaryColor,
                                  ));
                                } else {
                                  for (int i = 0;
                                      i < currentCart.cartItems!.length;
                                      i++) {
                                    if (currentCart
                                            .cartItems![i].product.title ==
                                        product.title) {
                                      if (currentCart.cartItems![i].numOfItem +
                                              numOfItemToAdd >
                                          product.stock) {
                                        if (product.stock -
                                                currentCart
                                                    .cartItems![i].numOfItem <
                                            1) {
                                          problem = true;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "You have all items in your cart!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            duration: Duration(seconds: 1),
                                            backgroundColor: kPrimaryColor,
                                          ));
                                        } else {
                                          problem = true;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "You can only add " +
                                                  (product.stock -
                                                          currentCart
                                                              .cartItems![i]
                                                              .numOfItem)
                                                      .toString() +
                                                  " items more!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            duration: Duration(seconds: 1),
                                            backgroundColor: kPrimaryColor,
                                          ));
                                        }
                                      } else if (!problem) {
                                        currentCart.cartItems![i].numOfItem +=
                                            numOfItemToAdd;

                                        currentWish.cartItems2![i].numOfItem +=
                                            numOfItemToAddWish;
                                        if (loginStatus == true) {
                                          await addToCartDB(
                                              product.title,
                                              currentCart
                                                  .cartItems![i].numOfItem);
                                        }
                                        // await addToWishDB(product.title, currentWish.cartItems2![i].numOfItem);

                                        found = true;
                                      }
                                    }
                                  }
                                  ;
                                  if (!found && !problem) {
                                    currentCart.cartItems!.add(CartItem(
                                        product: product,
                                        numOfItem: numOfItemToAdd));

                                    // currentWish.cartItems2!.add(WishItem(numOfItem:numOfItemToAddWish,
                                    // product: product ));
                                    if (loginStatus == true) {
                                      await addToCartDB(
                                          product.title, numOfItemToAdd);

                                      //   await addToWishDB(product.title, numOfItemToAddWish);
                                    }
                                  }
                                  ;
                                  if (!problem) {
                                    count = count + numOfItemToAdd;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                        "Added to cart!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      duration: Duration(seconds: 1),
                                      backgroundColor: kPrimaryColor,
                                    ));
                                    Navigator.of(context).pop();
                                  }
                                }
                                ;
                              },
                            ),
                            SizedBox(height: 10.0),
                            DefaultButton(
                              text: "Add To WishList",
                              press: () async {
                                if (loginStatus) {
                                  await FirebaseFirestore.instance
                                      .collection("Users")
                                      .doc(user!.uid)
                                      .get()
                                      .then((gelenveri) {
                                    wishList = gelenveri.data()!["wishList"];

                                    if (wishList == null) {
                                      wishList = {product.title: 1};
                                    } else {
                                      if (wishList!
                                          .containsKey(product.title)) {
                                        wishList![product.title] =
                                            wishList![product.title] + 1;
                                      } else {
                                        wishList![product.title] = 1;
                                      }
                                    }
                                  }).then((value) => FirebaseFirestore.instance
                                          .collection("Users")
                                          .doc(user!.uid)
                                          .update({"wishList": wishList}));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "Please login to update wish list!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 1),
                                    backgroundColor: kPrimaryColor,
                                  ));
                                }
                              },
                            ),
                            SizedBox(height: 10.0),
                            DefaultButton(
                                text: "See comments",
                                press: () => SchedulerBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      // add your code here.

                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => Reviews(
                                                  itemname: product.title)));
                                    })),
                          ])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
