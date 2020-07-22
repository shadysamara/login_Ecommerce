import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/customer/models/customer_product.dart';
import 'package:login_ecommerce/features/customer/models/order.dart';
import 'package:login_ecommerce/features/customer/repositories/db_client.dart';
import 'package:login_ecommerce/features/customer/repositories/fs_client.dart';

class CustomerRepository {
  CustomerRepository._();
  static CustomerRepository customerRepository = CustomerRepository._();
  addNewProduct(DBProduct product) async {
    int rowNum = await DBClient.dbClient.addNewProductToDatabase(product);
    print(rowNum);
  }

  addNewOrder(Order order) async {
    String orderDocId = await FSclient.adminClient.addNewOrder(order.toJson());
    print(orderDocId);
  }

  Future<List<DBProduct>> getAllProductsInShoppingCart() async {
    List<Map<String, dynamic>> products =
        await DBClient.dbClient.getAllProductsFromDB();
    List<DBProduct> productsList =
        products.map((e) => DBProduct.fromMap(e)).toList();
    return productsList;
  }

  Future<List<Order>> getAllOrdersFromFirestore() async {
    List<DocumentSnapshot> documents =
        await FSclient.adminClient.getAllOrders();
  }

  increaseProductCountInShoppingCart(DBProduct product) async {
    DBClient.dbClient.updateProduct(product);
  }

  deleteProductFromShoppingCart(String productId) async {
    DBClient.dbClient.deleteProductFormCart(productId);
  }
}
