import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ecommerce/features/customer/models/customer_product.dart';
import 'package:login_ecommerce/features/customer/models/order.dart';
import 'package:login_ecommerce/features/customer/repositories/customer_repository.dart';
import 'package:login_ecommerce/features/customer/repositories/db_client.dart';

class CustomerProvider extends ChangeNotifier {
  List<DBProduct> allDbProducts = [];

  getProductsFromDB() async {
    List<DBProduct> products = await CustomerRepository.customerRepository
        .getAllProductsInShoppingCart();
    allDbProducts = products;
    notifyListeners();
  }

  addProductToCart(DBProduct product) async {
    await CustomerRepository.customerRepository.addNewProduct(product);
    getProductsFromDB();
  }

  addOrderToFs() async {
    DateTime dateTime = DateTime.now();
    Order order = Order(
        address: 'gaza',
        date: '$dateTime',
        products: allDbProducts,
        userId: 'ddd');
  }
}
