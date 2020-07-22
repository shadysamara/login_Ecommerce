import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_ecommerce/components/models/product.dart';
import 'package:login_ecommerce/features/admin/providers/admin_provider.dart';
import 'package:login_ecommerce/features/admin/ui/admin_product_item.dart';
import 'package:login_ecommerce/features/admin/ui/cutom_textfield.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Admin Home'),
            bottom: TabBar(tabs: [
              Tab(
                text: 'New Product',
              ),
              Tab(
                text: 'All Products',
              )
            ]),
          ),
          body: TabBarView(children: [AddNewProduct(), AllProducts()]),
        ));
  }
}

enum textFieldType { name, description, price }

class AddNewProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        GestureDetector(onTap: () async {
          PickedFile imageFile = await ImagePicker().getImage(
              source: ImageSource.camera, maxWidth: 250, maxHeight: 250);
          File file = File(imageFile.path);
          Provider.of<AdminProvider>(context, listen: false).uploadImage(file);
        }, child: Consumer<AdminProvider>(
          builder: (context, value, child) {
            String imageUrl = value.imageUrl;
            if (imageUrl == null) {
              return Container(
                height: 250,
                width: 250,
                color: Colors.grey,
              );
            } else {
              return CachedNetworkImage(
                imageUrl: imageUrl,
                height: 250,
                width: 250,
              );
            }
          },
        )),
        CustomTestField(
          label: 'ProductName',
          type: textFieldType.name,
        ),
        CustomTestField(
          label: 'ProductDiscription',
          type: textFieldType.description,
        ),
        CustomTestField(
          label: 'ProductPrice',
          type: textFieldType.price,
        ),
        Spacer(),
        RaisedButton(onPressed: () {
          Provider.of<AdminProvider>(context, listen: false).addNewProduct();
        })
      ],
    );
  }
}

class AllProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AdminProvider>(context, listen: false).getAllProducts();
    // TODO: implement build
    return Consumer<AdminProvider>(
      builder: (context, value, child) {
        List<Product> allProducts = value.allProducts;
        if (allProducts.isEmpty) {
          return Center(
            child: Text('No Products Found'),
          );
        } else {
          return ListView.builder(
            itemCount: allProducts.length,
            itemBuilder: (context, index) {
              return AdminProduct(
                product: allProducts[index],
              );
            },
          );
        }
      },
    );
  }
}
