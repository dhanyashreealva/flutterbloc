import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';
import 'reservation_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservation + Payment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: BlocProvider(
        create: (context) => PaymentBloc(),
        child: ReservationPage(),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final double amount = 270.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Payment'),
        centerTitle: true,
        actions: [Icon(Icons.home), SizedBox(width: 10)],
      ),
      body: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is PaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Payment of ₹${state.amount} via ${state.provider} successful!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Payment failed: ${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amount to be paid now'),
                    Text(
                      '₹$amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 76, 175, 80),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 246, 245),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ListTile(
                    leading: Image.asset(
                         'assets/images/upi_logo.png',
                       width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                      ),
                     title: Text('UPI', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    buildUPIOption(context, 'PhonePe', Icons.account_balance_outlined),
                    buildUPIOption(context, 'Google Pay', Icons.payment),
                    buildUPIOption(context, 'Paytm', Icons.account_balance),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Row(
                  children: const [
                    Icon(Icons.credit_card),
                    SizedBox(width: 8),
                    Text("Credit/Debit/ATM Card"),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Card payment form goes here..."),
                  )
                ],
              ),
              ExpansionTile(
                title: Row(
                  children: const [
                    Icon(Icons.account_balance),
                    SizedBox(width: 8),
                    Text("Net Banking"),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Net banking options go here..."),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUPIOption(BuildContext context, String name, IconData icon) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        String selectedUPI = '';
        bool isProcessing = false;

        if (state is PaymentUPISelected) {
          selectedUPI = state.selectedProvider;
        } else if (state is PaymentProcessing) {
          selectedUPI = state.provider;
          isProcessing = true;
        }

        return Column(
          children: [
            RadioListTile(
             value: name,
            groupValue: selectedUPI,
             onChanged: isProcessing ? null : (value) {
             context.read<PaymentBloc>().add(SelectUPIProvider(value.toString()));
           },
          title: Text(name),
              secondary: name == 'PhonePe'
            ? Image.asset('assets/images/phonepe_logo.png', width: 24, height: 24)
              : name == 'Google Pay'
             ? Image.asset('assets/images/googlepay_logo.png', width: 24, height: 24)
              : name == 'Paytm'
              ? Image.asset('assets/images/paytm_logo.png', width: 24, height: 24)
              : Icon(icon),
         ),

            if (selectedUPI == name)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 3, 99, 3),
                      foregroundColor: Colors.white,  
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: isProcessing ? null : () {
                      context.read<PaymentBloc>().add(ProcessPayment(name, amount));
                    },
                    child: isProcessing
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Processing...',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : Text(
                            'Pay ₹$amount',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
