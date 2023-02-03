import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/helper/database_manager.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/screens/sign_in/components/login_firebase.dart';

import '../../../main.dart';
import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

/*
class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
        itemCount: currentCart.cartItems!.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Dismissible(
            key: Key(currentCart.cartItems![index].product.id.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async{
              if (loginStatus == true)
                await removeFromCartDB(currentCart.cartItems!.elementAt(index).product.title);
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
    );
  }
}


*/
class _BodyState extends State<Body> {
  List<Pair> pairs = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: FutureBuilder(
            future: getWishListItems(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: ListView.builder(
                    itemCount: pairs.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Dismissible(
                        key: Key((pairs[index].a as Product).id.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          if (loginStatus == true)
                            decreaseWishList((pairs[index].a as Product).title);
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
                        child: CartCard(
                            cart: CartItem(
                                product: pairs[index].a,
                                numOfItem: pairs[index].b)),
                      ),
                    ),
                  ),
                );
              }
            }));
  }

  Future<List<Pair>> getWishListItems() async {
    if (loginStatus == false) {
      return [];
    }
    for (var v in wishList!.entries) {
      await FirebaseFirestore.instance
          .collection("products_new")
          .doc(v.key)
          .get()
          .then((gelenveri) {
        Product a = Product(
          id: gelenveri.data()!["id"],
          images: gelenveri.data()!["images"],
          rating: gelenveri.data()!["rating"],
          isPopular: gelenveri.data()!["isPopular"],
          title: gelenveri.data()!["title"],
          price: gelenveri.data()!["price"],
          description: gelenveri.data()!["description"],
          category: gelenveri.data()!["category"],
          stock: gelenveri.data()!["stock"],
          numsold: gelenveri.data()!["timesold"],
        );

        Pair b = Pair(a, v.value);
        pairs.add(b);
      });
    }

    return pairs;
  }

  decreaseWishList(String name) async {
    if (wishList![name] == 1) {
      wishList!.remove(name);
    } else {
      wishList![name] -= 1;
    }

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .update({"wishList": wishList});
  }
}

class Pair<Product, Int> {
  final Product a;
  final Int b;

  Pair(this.a, this.b);
}
