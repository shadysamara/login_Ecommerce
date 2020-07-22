import 'dart:io';

import 'package:flutter/material.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/admin/repositories/admin_client.dart';
import 'package:login_ecommerce/features/admin/repositories/admin_repository.dart';

class AdminProvider extends ChangeNotifier {
  List<Product> allProducts = [];
  String productName;
  String productDescription;
  bool isAvailable = true;
  double price;
  String imageUrl;

  setProductName(String value) {
    this.productName = value;
  }

  setProductDescription(String value) {
    this.productDescription = value;
  }

  setIsAvailable(bool value) {
    this.isAvailable = value;
  }

  setPrice(String value) {
    this.price = double.parse(value);
  }

  uploadImage(File imageFile) async {
    String imageUrl = await AdminClient.adminClient.uploadImage(imageFile);
    this.imageUrl = imageUrl;
    print(imageUrl);
    notifyListeners();
  }

  Future<bool> addNewProduct() async {
    Product product = Product(
        description: this.productDescription,
        imageUrl: this.imageUrl,
        isAvailable: this.isAvailable,
        name: this.productName,
        price: this.price);
    String productId = await AdminClient.adminClient.addNewProduct(product);
    if (productId != null) {
      print(productId);
      getAllProducts();
      return true;
    } else {
      return false;
    }
  }

  getAllProducts() async {
    try {
      List<Product> products =
          await AdminRepository.adminRepository.getAllProducts();
      this.allProducts = products;

      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  deleteProduct(String documentId) async {
    await AdminClient.adminClient.deleteProduct(documentId);
    getAllProducts();
  }

  editProduct(Product product) async {
    await AdminClient.adminClient.editProduct(product);
    getAllProducts();
  }
}
