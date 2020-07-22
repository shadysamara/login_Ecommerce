import 'package:flutter/material.dart';
import 'package:login_ecommerce/features/admin/providers/admin_provider.dart';
import 'package:login_ecommerce/features/admin/ui/admin_home.dart';
import 'package:provider/provider.dart';

class CustomTestField extends StatelessWidget {
  String label;
  textFieldType type;
  CustomTestField({this.label, this.type});

  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    // TODO: implement build
    return TextField(
      onChanged: (value) {
        if (type == textFieldType.name) {
          adminProvider.setProductName(value);
        } else if (type == textFieldType.description) {
          adminProvider.setProductDescription(value);
        } else if (type == textFieldType.price) {
          adminProvider.setPrice(value);
        }
      },
      keyboardType: type == textFieldType.price
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
          labelText: this.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
