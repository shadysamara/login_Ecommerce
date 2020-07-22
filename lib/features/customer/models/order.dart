import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/customer/models/customer_product.dart';

class Order {
  List<DBProduct> products;
  List<Map> productsMap;
  String userId;
  String address;
  String date;
  Order({this.address, this.date, this.products, this.userId}) {
    productsMap = products.map((e) => e.toJson()).toList();
  }

  toJson() {
    return {
      'products': productsMap,
      'userId': this.userId,
      'address': this.address,
      'date': this.date
    };
  }
}
