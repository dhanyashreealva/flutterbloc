import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/CartItemsPage.dart';
import 'package:my_app/menuPage.dart';
//import 'package:my_app/menuPage.dart';
import 'ReservationConfirmationPage.dart';
import 'PaymentPage.dart';
import 'OrderSummaryPage.dart';
import 'CartPage.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'reservation_confirmation_bloc.dart';
import 'reservation_confirmation_event.dart';
//import 'TableSelectionPage.dart';
import 'restaurant_booking_page.dart';
import 'payment_bloc.dart';
//import 'menuPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(const LoadCart()),
        ),
        BlocProvider<ReservationConfirmationBloc>(
          create: (context) => ReservationConfirmationBloc()..add(LoadReservationConfirmation()),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Reservation Confirmation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home:CartLikeScreen(),
        routes: {
          '/confirmation': (context) => ReservationConfirmationPage(),
          '/booking': (context) => RestaurantBookingPage(),
          '/payment': (context) => PaymentPage(),
          '/orderSummary': (context) => OrderSummaryPage(),
          '/cart': (context) => CartPage(),
          '/cartItems': (context) => CartItemsPage(),
          '/MenuPage':(context)=>CartLikeScreen(),
        },
      ),
    );
  }
}
