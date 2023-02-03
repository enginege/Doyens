// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/enums.dart';
import 'package:shop_app/models/Transaction.dart';
import 'package:shop_app/models/Transaction2.dart';
import 'package:shop_app/screens/profile/my_orders/order_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'order_details_all.dart';

List<TransactionClass> transactions = [];
TransactionClass newtrans =
    new TransactionClass(purchaseDate: new Timestamp(0, 0), items: {});

class AllTransactionsScreen2 extends StatefulWidget {
  @override
  State<AllTransactionsScreen2> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen2> {
  //_TransactionScreenState createState() => _TransactionScreenState();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('transactions').snapshots();
  DateTime startDate = new DateTime(1);
  DateTime endDate = new DateTime(3000);
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
        transactions.clear();
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          for (var key in data.keys) {
            //print(document.id);
            newtrans = new TransactionClass(
              //Problem is here THE KID
                
                address: (data['address'] != null) ? data['address'] : "NotGiven",
                totalprice: data['totalprice'],
                orderstatus: data['orderstatus'],
                user: data['user'],
                transactionid: document.id,
                invoicePath: data['invoicePath'] ?? "null",
                purchaseDate: data['date'],
                items: data["itemsandprice"]);
                //deliveryAddress: data['deliveryAddress']);
          }
          if (startDate.isBefore(newtrans.purchaseDate.toDate()) &&
              endDate.isAfter(newtrans.purchaseDate.toDate()) /*&& newtrans.orderstatus != "completed"*/) {
            transactions.add(newtrans);
          }
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
            endDrawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: DrawerHeader(
                      child: Text(
                        'FILTER',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('From: ' +
                        (DateFormat('dd/MM/yyyy')
                                    .format(startDate)
                                    .toString() !=
                                "01/01/0001"
                            ? DateFormat('dd/MM/yyyy')
                                .format(startDate)
                                .toString()
                            : "")),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          maxTime: DateTime.now(),
                          theme: DatePickerTheme(
                            headerColor: kPrimaryColor,
                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            cancelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ), onConfirm: (date) {
                        setState(() {
                          startDate = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                  ),
                  ListTile(
                    title: Text('To: ' +
                        (DateFormat('dd/MM/yyyy').format(endDate).toString() !=
                                "01/01/3000"
                            ? DateFormat('dd/MM/yyyy')
                                .format(endDate)
                                .toString()
                            : "")),
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          maxTime: DateTime.now(),
                          theme: DatePickerTheme(
                            headerColor: kPrimaryColor,
                            backgroundColor: Colors.white,
                            itemStyle: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            cancelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ), onConfirm: (date) {
                        setState(() {
                          endDate = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                CustomBottomNavBar(selectedMenu: MenuState.profile),
            body: ListView(
              children: [
                ListView.builder(
                  itemCount: transactions.length,
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
                          _orderStatus(transactions[index].orderstatus),
                          Divider(color: Colors.grey),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              iconText(
                                  Icon(
                                    Icons.edit,
                                    color: kPrimaryColor,
                                  ),
                                  Text(
                                    "Order ID",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(transactions[index].transactionid,
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
                                      .format(transactions[index]
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
                                  transactions[index].totalprice.toString() +
                                      '\$',
                                  style: TextStyle(fontSize: 14))
                            ],
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
                                    "Delivery Address",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                  transactions[index].address,
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
                                      builder: (context) => OrderDetailsAllPage2(
                                            transaction: transactions[index],
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
