import 'package:flutter/material.dart';
import 'package:login_ecommerce/features/admin/providers/admin_provider.dart';
import 'package:login_ecommerce/features/admin/ui/admin_home.dart';
import 'package:login_ecommerce/features/customer/ui/customer_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminProvider>(
          create: (context) {
            return AdminProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: CustomerHome(),
      ),
    );
  }
}
