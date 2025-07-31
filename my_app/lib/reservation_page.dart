import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_bloc.dart';
import 'payment_page.dart';

class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reservation')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<PaymentBloc>(context),
                  child: PaymentPage(amount: 270.75),
                ),
              ),
            );
          },
          child: Text('NEXT'),
        ),
      ),
    );
  }
}
