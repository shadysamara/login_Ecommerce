import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/admin/repositories/admin_client.dart';

class AdminRepository {
  AdminRepository._();
  static AdminRepository adminRepository = AdminRepository._();
  Future<List<Product>> getAllProducts() async {
    try {
      List<DocumentSnapshot> documents =
          await AdminClient.adminClient.getAllProducts();

      List<Product> products =
          documents.map((e) => Product.fromDocumetSnapshot(e)).toList();

      return products;
    } catch (error) {
      print(error);
    }
  }
}
