import 'package:cloud_firestore/cloud_firestore.dart';


class TransactionClass2 {
  num totalprice = 0;
  String user = "a";
  String transactionid = "a";
  String orderstatus = "placed";
  String invoicePath = "";
  Timestamp purchaseDate;
  Map<String, dynamic> items = {"test": 1};
  String deliveryAddress = "NotGiven";
  TransactionClass2(
    
      {this.totalprice = 1,
      this.user = "a",
      this.transactionid = "a",
      this.orderstatus = "placed",
      this.invoicePath = "",
      this.deliveryAddress="NotGiven",
      required this.purchaseDate,
      required this.items});

// Our demo Products
}