import 'package:shop_app/screens/home/components/body.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'Product.dart';

class WishItem {
  final Product product;
  int numOfItem;

  WishItem({required this.product, required this.numOfItem});
}

// Demo data for our cart
class Cart2 {
  num sum = 0;
  List<WishItem>? cartItems2 = [
    WishItem(product: productListnew[0], numOfItem: 2),
  ];
  num sumAll() {
    if (sum != 0) {
      sum = 0;
    }
    for (int i = 0; i < cartItems2!.length; i++) {
      sum += cartItems2![i].product.price * cartItems2![i].numOfItem;
    }
    sum = num.parse(sum.toStringAsFixed(2));
    return sum;
  }

  Cart2({required this.sum, this.cartItems2});
}

Cart2 currentWish = Cart2(sum: 0, cartItems2: []);
