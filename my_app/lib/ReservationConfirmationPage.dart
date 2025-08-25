import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_confirmation_bloc.dart';
import 'reservation_confirmation_event.dart';
import 'reservation_confirmation_state.dart';
import 'cart_bloc.dart';
import 'cart_state.dart';
import 'CartPage.dart';

class ReservationConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? confirmationNumber = ModalRoute.of(context)?.settings.arguments as String?;
    
    return BlocProvider(
      create: (context) => ReservationConfirmationBloc()
        ..add(LoadReservationConfirmation()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<ReservationConfirmationBloc, ReservationConfirmationState>(
            listenWhen: (previous, current) =>
                previous.status != current.status && current.status == ReservationConfirmationStatus.failure,
            listener: (context, state) {
              if (state.status == ReservationConfirmationStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'An error occurred'),
                    backgroundColor: Color(0xFFB97A3B),
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildRestaurantName(context, confirmationNumber),
                  _buildSummaryDetails(context),
                  _buildContactInfo(context),
                  _buildRulesRestrictions(),
                  _buildBillDetails(),
                  _buildProceedButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(Icons.arrow_back, color: Colors.black, size: 36),
          ),
          Expanded(
            child: Text(
              'Reservation Confirmation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Icon(Icons.home_outlined, color: Colors.black, size: 36),
          ),
        ],
      ),
    );
  }

 Widget _buildRestaurantName(BuildContext context, String? confirmationNumber) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Removed vertical gap
    child: Text(
      'The Grand Kitchen-Multi Cuisine Restaurant',
      style: TextStyle(
        color: Colors.brown.shade400,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
  );
}


  Widget _buildSummaryDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSummaryRow(Icons.restaurant_menu, 'Party of 2', 'The Grand Kitchen-Multi Cuisine Restaurant'),
          SizedBox(height: 8),
          _buildSummaryRow(Icons.calendar_today, 'Sunday 15 June', '6:30 GMT+6:00'),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CartPage()),
              );
            },
            child: Row(
              children: [
                Icon(Icons.ramen_dining, size: 24, color: Colors.black),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items list', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('View items', style: TextStyle(color: const Color.fromARGB(255, 15, 17, 20), decoration: TextDecoration.underline)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.black),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Info', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              String contactNumber = '';
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text('Add Contact Number'),
                    content: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        contactNumber = value;
                      },
                      decoration: InputDecoration(hintText: 'Enter contact number'),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (contactNumber.isNotEmpty) {
                            context.read<ReservationConfirmationBloc>().add(AddContactInfo(contactNumber));
                          }
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text('Save'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<ReservationConfirmationBloc, ReservationConfirmationState>(
                      builder: (context, state) {
                        return Text(
                          state.contactInfo ?? 'Add Contact Info',
                          style: TextStyle(
                            fontWeight: state.contactInfo != null ? FontWeight.normal : FontWeight.bold,
                            color: state.contactInfo != null ? Colors.black : Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesRestrictions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rules & Restrictions', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.cancel, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Cancellation policy\n',
                            style: TextStyle(color: Colors.red),
                          ),
                          TextSpan(
                            text: 'If you can’t make it your reservation, please cancel your reservation in advance.',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'NOTE: 30% advance is required to confirm your booking. The remaining amount is payable at the restaurant.',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
  }

  Widget _buildBillDetails() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BILL DETAILS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 16),
              _buildBillRow('Items Total', '₹${state.itemsTotal.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              _buildBillRow('Tax', '₹${state.tax.toStringAsFixed(2)}'),
              Divider(color: Colors.grey.shade400, height: 24),
              _buildBillRow('Grand total', '₹${state.grandTotal.toStringAsFixed(2)}', isTotal: true),
              SizedBox(height: 8),
              _buildBillRow('Advance payment(30%)', '₹${(state.grandTotal * 0.3).toStringAsFixed(2)}', isTotal: true, isAdvance: true),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillRow(String label, String amount, {bool isTotal = false, bool isAdvance = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isAdvance ? Colors.red : Colors.black)),
        Text(amount, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isAdvance ? Colors.red : Colors.black)),
      ],
    );
  }

  Widget _buildProceedButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade800,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/payment');
          },
          child: Text('PROCEED TO PAY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }
}
