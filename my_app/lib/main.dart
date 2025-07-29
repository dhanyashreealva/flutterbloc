import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedUPI = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Payment'),
        centerTitle: true,
        actions: [Icon(Icons.home), SizedBox(width: 10)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Amount to be paid
            Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Amount to be paid now'),
                  Text(
                    '₹270.75',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),

            // UPI Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Text('🇮🇳', style: TextStyle(fontSize: 20)),
                    title: Text('UPI', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  buildUPIOption('PhonePe', Icons.account_balance_wallet_outlined),
                  buildUPIOption('Google Pay', Icons.payment),
                  buildUPIOption('Paytm', Icons.account_balance),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Credit/Debit/ATM
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

            // Net Banking
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
    );
  }

  Widget buildUPIOption(String name, IconData icon) {
    return Column(
      children: [
        RadioListTile(
          value: name,
          groupValue: _selectedUPI,
          onChanged: (value) {
            setState(() {
              _selectedUPI = value.toString();
            });
          },
          title: Text(name),
          secondary: Icon(icon),
        ),
        if (_selectedUPI == name)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Paying ₹270.75 via $name'),
                  ));
                },
                child: Text(
                  'Pay ₹270.75',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
