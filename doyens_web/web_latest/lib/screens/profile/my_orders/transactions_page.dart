// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/Transaction.dart';
import 'package:shop_app/screens/profile/my_orders/order_details.dart';
import 'package:shop_app/screens/sign_in/components/login_firebase.dart';
import 'package:intl/intl.dart';


List<TransactionClass> userTransaction = [];
TransactionClass newtrans =
    new TransactionClass(purchaseDate: new Timestamp(0, 0), items: {});

class TransactionScreen extends StatelessWidget {
  //_TransactionScreenState createState() => _TransactionScreenState();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('transactions').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        userTransaction.clear();
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          for (var key in data.keys) {
            //print(document.id);
            newtrans = new TransactionClass(
                totalprice: data['totalprice'],
                orderstatus: data['orderstatus'],
                user: data['user'],
                transactionid: document.id,
                invoicePath: data['invoicePath'] ?? "null",
                purchaseDate: data['date'],
                items: data["itemsandprice"]);
          }
          if (data['user'] == user!.uid) userTransaction.add(newtrans);
        }).toList();
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "ORDERS",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            bottomNavigationBar:
                CustomBottomNavBar(selectedMenu: MenuState.profile),
            body: ListView(
              children: [
                ListView.builder(
                  itemCount: userTransaction.length,
                  physics: ScrollPhysics(),
                  padding: EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          SizedBox(height: 20),
                          _orderStatus(userTransaction[index].orderstatus),
                          Divider(color: Colors.grey),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconText(
                                  Icon(Icons.edit, color: kPrimaryColor,),
                                  Text(
                                    "Order ID",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(userTransaction[index].transactionid,
                                  style: TextStyle(fontSize: 10))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconText(
                                  Icon(
                                    Icons.today,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    "Order Date",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                  DateFormat('dd/MM/yyyy, HH:mm')
                                      .format(userTransaction[index]
                                          .purchaseDate
                                          .toDate())
                                      .toString(),
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconText(
                                  Icon(
                                    Icons.price_check,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    "Price Paid",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                  userTransaction[index].totalprice.toString() +
                                      '\$',
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              flatButton(
                                Row(
                                  children: [
                                    Text("Order Details"),
                                    Icon(Icons.chevron_right)
                                  ],
                                ),
                                Colors.green,
                                () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OrderDetailsPage(
                                            transaction: userTransaction[index],
                                          )));
                                },
                              ),
                            ],
                          )
                        ]),
                      ),
                    );
                  },
                )
              ],
            ));
      },
    );
  }

  Widget iconText(Icon iconWidget, Text textWidget) {
    return Row(children: [
      iconWidget,
      SizedBox(
        width: 5,
      ),
      textWidget
    ]);
  }

  Widget flatButton(Widget iconText, Color color, Function pres) {
    return TextButton(
      onPressed: () => pres(),
      child: iconText,
      // padding: EdgeInsets.all(5),
      // color: color,
      // shape: StadiumBorder(),
    );
  }

  Widget _orderStatus(String status) {
    Icon icon = Icon(Icons.face);
    Color color;

    if (status == "placed" || status == "shipping") {
      icon = Icon(Icons.timer, color: kPrimaryColor);
    } else if (status == "completed") {
      icon = Icon(Icons.check, color: kPrimaryColor);
    } else if (status == "cancelled" || status == "refunded") {
      icon = Icon(Icons.clear, color: kPrimaryColor);
    }
    return iconText(icon, Text("Order Status: " + status.toUpperCase()));
  }
}
