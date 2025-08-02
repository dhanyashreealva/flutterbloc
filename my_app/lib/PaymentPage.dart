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
  String? _selectedPaymentCategory = 'UPI';
  String? _expandedCategory = 'UPI';

  final List<String> paymentCategories = ['UPI', 'Credit/Debit/ATM Card', 'Net Banking'];

  final List<Map<String, String>> upiProviders = [
    {'name': 'PhonePe', 'icon': 'assets/images/phonepe_logo.png'},
    {'name': 'Google Pay', 'icon': 'assets/images/googlepay_logo.png'},
    {'name': 'Paytm', 'icon': 'assets/images/paytm_logo.png'},
  ];

  final List<Map<String, String>> cardOptions = [
    {'name': 'Visa'},
    {'name': 'MasterCard'},
    {'name': 'American Express'},
  ];

  final List<Map<String, String>> netBankingOptions = [
    {'name': 'HDFC Bank'},
    {'name': 'ICICI Bank'},
    {'name': 'State Bank of India'},
  ];

  void _onExpansionChanged(String category, bool expanded) {
    setState(() {
      _expandedCategory = expanded ? category : null;
      _selectedPaymentCategory = expanded ? category : _selectedPaymentCategory;
    });
  }

  Widget _buildAmountToPay() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final advanceAmount = cartState.grandTotal * 0.3;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount to be paid now',
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                '₹${advanceAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.green.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
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
        return Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
          ),
          child: Column(
            children: [
              ListTile(
                leading: Radio<String>(
                  value: provider['name']!,
                  groupValue: selectedProvider,
                  onChanged: (value) {
                    context.read<PaymentBloc>().add(SelectUPIProvider(value!));
                  },
                  activeColor: Colors.green,
                ),
                title: Text(
                  provider['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.black : Colors.black87,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade800,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          onPressed: () {
                            context.read<PaymentBloc>().add(
                                  ProcessPayment(provider['name']!, advanceAmount),
                                );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pay ₹${advanceAmount.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(width: 8),
                              Image.asset(
                                'assets/images/upi_logo.png',
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCardOptions(String? selectedCard) {
    return Column(
      children: cardOptions.map((card) {
        final isSelected = selectedCard == card['name'];
        return ListTile(
          leading: Radio<String>(
            value: card['name']!,
            groupValue: selectedCard,
            onChanged: (value) {
              context.read<PaymentBloc>().add(SelectCardOption(value!));
            },
            activeColor: Colors.green,
          ),
          title: Text(
            card['name']!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNetBankingOptions(String? selectedNetBanking) {
    return Column(
      children: netBankingOptions.map((netBank) {
        final isSelected = selectedNetBanking == netBank['name'];
        return ListTile(
          leading: Radio<String>(
            value: netBank['name']!,
            groupValue: selectedNetBanking,
            onChanged: (value) {
              context.read<PaymentBloc>().add(SelectNetBankingOption(value!));
            },
            activeColor: Colors.green,
          ),
          title: Text(
            netBank['name']!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAmountToPay(),
            ExpansionTile(
              initiallyExpanded: _expandedCategory == 'UPI',
              title: Row(
                children: [
                  Image.asset('assets/images/upi_logo.png', height: 20, width: 20),
                  SizedBox(width: 8),
                  Text(
                    'UPI',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              onExpansionChanged: (expanded) => _onExpansionChanged('UPI', expanded),
              children: [
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    String? selectedProvider;
                    if (state is PaymentUPISelected) {
                      selectedProvider = state.selectedProvider;
                    }
                    return _buildUPIOptions(selectedProvider);
                  },
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: _expandedCategory == 'Credit/Debit/ATM Card',
              title: Row(
                children: [
                  Icon(Icons.credit_card, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Credit/Debit/ATM Card',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              onExpansionChanged: (expanded) => _onExpansionChanged('Credit/Debit/ATM Card', expanded),
              children: [
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    String? selectedCard;
                    if (state is PaymentCardSelected) {
                      selectedCard = state.selectedCardOption;
                    }
                    return _buildCardOptions(selectedCard);
                  },
                ),
              ],
            ),
            ExpansionTile(
              initiallyExpanded: _expandedCategory == 'Net Banking',
              title: Row(
                children: [
                  Icon(Icons.account_balance, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Net Banking',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              onExpansionChanged: (expanded) => _onExpansionChanged('Net Banking', expanded),
              children: [
                BlocBuilder<PaymentBloc, PaymentState>(
                  builder: (context, state) {
                    String? selectedNetBanking;
                    if (state is PaymentNetBankingSelected) {
                      selectedNetBanking = state.selectedNetBankingOption;
                    }
                    return _buildNetBankingOptions(selectedNetBanking);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
