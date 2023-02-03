import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/refundModal.dart';
import 'package:shop_app/screens/sales_manager/refunds/pending_refund.dart';
import 'package:shop_app/screens/sales_manager/revenue/revenue.dart';
import '../../../models/Transaction.dart';
import '../revenue/revenue.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

List<TransactionClass> transactions = [];
TransactionClass newtrans =
    new TransactionClass(purchaseDate: new Timestamp(0, 0), items: {});

class revenueScreen extends StatefulWidget {
  static String routeName = "/smanagerRevenue";
  revenueScreen({Key? key}) : super(key: key);
  @override
  _RevenueState createState() => _RevenueState();
}

class _RevenueState extends State<revenueScreen> {
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
            newtrans = new TransactionClass(
                totalprice: data['totalprice'],
                orderstatus: data['orderstatus'],
                user: data['user'],
                transactionid: document.id,
                invoicePath: data['invoicePath'] ?? "null",
                purchaseDate: data['date'],
                items: data["itemsandprice"]);
          }
          if (startDate.isBefore(newtrans.purchaseDate.toDate()) &&
              endDate.isAfter(newtrans.purchaseDate.toDate())) {
            transactions.add(newtrans);
          }
        }).toList();
        return revenueUI();
      },
    );
  }

  Widget revenueUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "REVENUE",
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
              itemCount: 1, //Change
              itemBuilder: (context, index) {
                return Container(); /*RevenueUI(
                  
                );*/
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
