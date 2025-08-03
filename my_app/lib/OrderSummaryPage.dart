import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';
import 'order_summary_bloc.dart';
import 'order_summary_event.dart';
import 'order_summary_state.dart';

class OrderSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderSummaryBloc(cartBloc: context.read<CartBloc>())..add(LoadOrderSummary()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<OrderSummaryBloc, OrderSummaryState>(
            builder: (context, state) {
              if (state.status == OrderSummaryStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.status == OrderSummaryStatus.failure) {
                return Center(child: Text(state.errorMessage ?? 'Error loading order summary'));
              } else if (state.status == OrderSummaryStatus.success) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      _buildBookingDetails(state),
                      _buildPaymentSummary(state),
                      _buildOrderSummary(context),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.shade700,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'ORDER CONFIRMED',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your table is reserved!',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails(OrderSummaryState state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BOOKING DETAILS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'The Grand Kitchen-Multi Cuisine Restaurant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.brown.shade700,
              ),
            ),
          ),
          SizedBox(height: 12),
          _buildDetailRow(Icons.group, 'Party of ${state.partySize ?? '-'}'),
          _buildDetailRow(Icons.calendar_today, '${state.bookingDate ?? '-'}'),
          _buildDetailRow(Icons.access_time, '${state.bookingTime ?? '-'}'),
          _buildDetailRow(Icons.table_bar, 'Table no: ${state.tableNumber ?? '-'}'),
          _buildDetailRow(Icons.confirmation_num, 'Booking ID: ${state.bookingId ?? '-'}'),
          _buildStatusRow('Status: ', state.statusMessage ?? '-'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String status) {
    Color statusColor = Colors.green;
    if (status.toLowerCase() != 'confirmed') {
      statusColor = Colors.red;
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary(OrderSummaryState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAYMENT SUMMARY',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: 12),
          _buildPaymentRow('Items Total', '₹${state.itemsTotal?.toStringAsFixed(2) ?? '-'}'),
          _buildPaymentRow('Tax', '₹${state.tax?.toStringAsFixed(2) ?? '-'}'),
          Divider(color: Colors.grey.shade400, height: 24),
          _buildPaymentRow('Grand total', '₹${state.grandTotal?.toStringAsFixed(2) ?? '-'}', isTotal: true),
          _buildPaymentRow('Amount Paid(30%)', '₹${state.amountPaid?.toStringAsFixed(2) ?? '-'}'),
          _buildPaymentRow('Balance Amount', '₹${state.balanceAmount?.toStringAsFixed(2) ?? '-'}'),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: isTotal ? Colors.red : Colors.black87,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: isTotal ? Colors.red : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ORDER SUMMARY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/cartItems');
                },
                child: Text(
                  'View items',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'THANK YOU',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Times New Roman',
              color: Colors.brown.shade700,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            },
            child: Icon(
              Icons.home,
              size: 48,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
