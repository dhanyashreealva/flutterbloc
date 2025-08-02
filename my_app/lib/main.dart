import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ReservationConfirmationPage.dart';
import 'PaymentPage.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'reservation_confirmation_bloc.dart';
import 'reservation_confirmation_event.dart';
import 'restaurant_booking_page.dart';
import 'payment_bloc.dart';

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
        home: RestaurantBookingPage(),
        routes: {
          '/confirmation': (context) => ReservationConfirmationPage(),
          '/booking': (context) => RestaurantBookingPage(),
          '/payment': (context) => PaymentPage(),
        },
      ),
    );
  }
}
