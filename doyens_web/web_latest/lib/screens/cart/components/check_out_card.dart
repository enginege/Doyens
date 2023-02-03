import 'package:flutter/material.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/screens/payment/payment_screen.dart';
import '../../../helper/database_manager.dart';
import '../../../size_config.dart';
import 'package:shop_app/models/Cart.dart';

import '../../profile/my_orders/settingsScreen.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  num totalsum = currentCart.sumAll();
  void _update(int count) {
    setState(() => totalsum = count);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(10),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 214, 210, 210),
        borderRadius: BorderRadius.only(),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 10,
            spreadRadius: 12,
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  Text(
                    "Total: ",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(8),
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${currentCart.sumAll()}",
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(8),
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
                SizedBox(
                  width: getProportionateScreenWidth(50),
                  child: DefaultButton(
                      text: "Check Out",
                      press: () async {
                        if (loginStatus == true) {
                          String address = await getAddress();

                          print(address);
                          if (currentCart.sumAll() > 0) {
                            print(loginStatus);
                            if (address != "NotGiven") {
                              Navigator.pushNamed(
                                  context, PaymentScreen.routeName);
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => settingsScreen()));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "Your address is not given, Please Check it!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                duration: Duration(seconds: 2),
                                backgroundColor: kPrimaryColor,
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                "Please add items to your cart!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              duration: Duration(seconds: 1),
                              backgroundColor: kPrimaryColor,
                            ));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "You need to login in order to check out!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            duration: Duration(seconds: 1),
                            backgroundColor: kPrimaryColor,
                          ));
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
