import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/values.dart/strings.dart';

class AdminClient {
  AdminClient._();
  static final AdminClient adminClient = AdminClient._();
  Firestore firestore = Firestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> uploadImage(File file) async {
    try {
      DateTime dateTime = DateTime.now();
      StorageTaskSnapshot snapshot = await firebaseStorage
          .ref()
          .child('products/$dateTime.jpg')
          .putFile(file)
          .onComplete;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print(error);
    }
  }

  Future<String> addNewProduct(Product product) async {
    try {
      DocumentReference documentReference = await firestore
          .collection(productsCollectionName)
          .add(product.toJson());
      return documentReference.documentID;
    } catch (error) {
      print(error);
    }
  }

  Future<List<DocumentSnapshot>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection(productsCollectionName).getDocuments();
      return querySnapshot.documents;
    } catch (error) {
      print(error);
    }
  }

  editProduct(Product product) async {
    try {
      firestore
          .collection(productsCollectionName)
          .document(product.documentId)
          .setData(product.toJson());
    } catch (e) {
      print(e);
    }
  }

  deleteProduct(String documentId) async {
    try {
      firestore
          .collection(productsCollectionName)
          .document(documentId)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
