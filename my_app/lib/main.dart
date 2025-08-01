import 'package:flutter/material.dart';
import 'restaurant_booking_page.dart';
import 'CartPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: RestaurantBookingPage(),
      routes: {
        '/booking': (context) => RestaurantBookingPage(),
        '/cartPage': (context) => CartPage(),
      },
    );
  }
}
