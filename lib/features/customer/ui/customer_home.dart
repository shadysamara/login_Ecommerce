import 'package:flutter/material.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/customer/repositories/customer_repository.dart';

class CustomerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: RaisedButton(onPressed: () {
          CustomerRepository.customerRepository.getAllProductsInShoppingCart();
        }),
      ),
    );
  }
}
