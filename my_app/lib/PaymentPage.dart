import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/payment_bloc.dart';
import 'package:my_app/payment_event.dart';
import 'package:my_app/payment_state.dart';
import 'package:my_app/cart_bloc.dart';
import 'package:my_app/cart_state.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _expandedCategory = 'UPI';

  final List<Map<String, String>> upiProviders = [
    {'name': 'PhonePe', 'icon': 'assets/images/phonepe_logo.png'},
    {'name': 'Google Pay', 'icon': 'assets/images/googlepay_logo.png'},
    {'name': 'Paytm', 'icon': 'assets/images/paytm_logo.png'},
  ];

  void _onExpansionChanged(String category, bool expanded) {
    setState(() {
      _expandedCategory = expanded ? category : null;
    });
  }
  

  Widget _buildAmountToPay() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final advanceAmount = cartState.grandTotal * 0.3;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Amount to be paid now',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              Text(
                '₹${advanceAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUPIOptions(String? selectedProvider) {
    return Column(
      children: upiProviders.map((provider) {
        final isSelected = selectedProvider == provider['name'];
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              leading: Radio<String>(
                value: provider['name']!,
                groupValue: selectedProvider,
                onChanged: (value) {
                  context.read<PaymentBloc>().add(SelectUPIProvider(value!));
                },
                activeColor: Colors.black,
              ),
              title: Text(
                provider['name']!,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Image.asset(
                provider['icon']!,
                height: 24,
                width: 24,
              ),
            ),
           
            if (isSelected)
              BlocBuilder<CartBloc, CartState>(
                builder: (context, cartState) {
                  final advanceAmount = cartState.grandTotal * 0.3;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          context.read<PaymentBloc>().add(
                                ProcessPayment(provider['name']!, advanceAmount),
                              );
                        },
                        child: Text(
                          'Pay ₹${advanceAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required Widget leadingIcon,
    required bool initiallyExpanded,
    required Function(bool) onExpand,
    required Widget content,
  }) {
    return Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      tilePadding: EdgeInsets.symmetric(horizontal: 0),
      childrenPadding: EdgeInsets.only(left: 8, right: 8, bottom: 10),
      title: Row(
        children: [
          leadingIcon,
          SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
      onExpansionChanged: onExpand,
      children: [content],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentSuccess) {
          await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Payment Successful'),
              content: Text(
                  'Your payment of ₹${state.amount.toStringAsFixed(2)} via ${state.provider} was successful.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, '/orderSummary');
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          context.read<PaymentBloc>().add(ResetPayment());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:Padding(padding: const EdgeInsets.only(top: 35.0),child: Text('Payment',style: TextStyle(fontWeight:FontWeight.bold),),),
          
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.5,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
                      Center(
                child: Container(
                  width: 350, 
                  child: Divider(
                    color: Colors.black,
                    thickness: 1,
                    height: 1,
                  ),
                ),
              ),
              _buildAmountToPay(),
              BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  String? selectedProvider;
                  if (state is PaymentUPISelected) {
                    selectedProvider = state.selectedProvider;
                  }
                  return _buildExpansionTile(
                    title: 'UPI',
                    leadingIcon: Image.asset('assets/images/upi_logo.png',
                        height: 20, width: 20),
                    initiallyExpanded: _expandedCategory == 'UPI',
                    onExpand: (expanded) => _onExpansionChanged('UPI', expanded),
                    content: _buildUPIOptions(selectedProvider),
                  );
                },
              ),
              _buildExpansionTile(
                title: 'Credit/Debit/ATM Card',
                leadingIcon: Icon(Icons.credit_card, size: 20),
                initiallyExpanded: _expandedCategory == 'Credit/Debit/ATM Card',
                onExpand: (expanded) =>
                    _onExpansionChanged('Credit/Debit/ATM Card', expanded),
                content: SizedBox(height: 40), // Placeholder for card options
              ),
              _buildExpansionTile(
                title: 'Net Banking',
                leadingIcon: Icon(Icons.account_balance, size: 20),
                initiallyExpanded: _expandedCategory == 'Net Banking',
                onExpand: (expanded) => _onExpansionChanged('Net Banking', expanded),
                content: SizedBox(height: 40), // Placeholder for net banking
              ),
            ],
          ),
        ),
      ),
    );
  }
}
