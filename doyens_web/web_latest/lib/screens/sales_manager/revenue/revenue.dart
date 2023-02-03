import 'package:flutter/material.dart';
import 'package:shop_app/helper/database_manager.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:shop_app/constants.dart';
import '../../../components/default_button.dart';

class RevenueUI extends StatelessWidget {
  final String name, itemName, refundid, transactionid;
  final num itemCount, pricePaid;
  const RevenueUI({
    Key? key,
    required this.itemName,
    required this.name,
    required this.pricePaid,
    required this.itemCount,
    required this.refundid,
    required this.transactionid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
