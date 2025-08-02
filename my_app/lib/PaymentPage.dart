import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import 'cart_bloc.dart';
import 'cart_state.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedUPIProvider = 'Google Pay';
  bool _showCardOptions = false;
  bool _showNetBankingOptions = false;

  final List<Map<String, String>> upiProviders = [
    {'name': 'PhonePe', 'icon': 'assets/images/phonepe_logo.png'},
    {'name': 'Google Pay', 'icon': 'assets/images/googlepay_logo.png'},
    {'name': 'Paytm', 'icon': 'assets/images/paytm_logo.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc()..add(SelectUPIProvider(_selectedUPIProvider!)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Payment'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
            ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmountToPay(),
                SizedBox(height: 16),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/upi_logo.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 8),
                    Text('UPI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 8),
                _buildUPIOptions(),
                SizedBox(height: 8),
                _buildPayButton(),
                SizedBox(height: 16),
                _buildExpandableSection(
                  title: 'Credit/Debit/ATM Card',
                  icon: Icons.credit_card,
                  isExpanded: _showCardOptions,
                  onTap: () {
                    setState(() {
                      _showCardOptions = !_showCardOptions;
                    });
                  },
                  content: _buildCardOptions(),
                ),
                SizedBox(height: 8),
                _buildExpandableSection(
                  title: 'Net Banking',
                  icon: Icons.account_balance,
                  isExpanded: _showNetBankingOptions,
                  onTap: () {
                    setState(() {
                      _showNetBankingOptions = !_showNetBankingOptions;
                    });
                  },
                  content: _buildNetBankingOptions(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountToPay() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        final advanceAmount = cartState.grandTotal * 0.3;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

  Widget _buildUPIOptions() {
    return Column(
      children: upiProviders.map((provider) {
        final isSelected = _selectedUPIProvider == provider['name'];
        final advanceAmount = context.read<CartBloc>().state.grandTotal * 0.3;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedUPIProvider = provider['name'];
            });
            context.read<PaymentBloc>().add(SelectUPIProvider(provider['name']!));
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.green.shade50 : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.symmetric(vertical: 4),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Radio<String>(
                  value: provider['name']!,
                  groupValue: _selectedUPIProvider,
                  onChanged: (value) {
                    setState(() {
                      _selectedUPIProvider = value;
                    });
                    context.read<PaymentBloc>().add(SelectUPIProvider(value!));
                  },
                  activeColor: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  provider['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.green.shade900 : Colors.black,
                  ),
                ),
                Spacer(),
                Image.asset(
                  provider['icon']!,
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 36,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.green.shade800 : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: isSelected
                        ? () {
                            context.read<PaymentBloc>().add(
                                  ProcessPayment(provider['name']!, advanceAmount),
                                );
                          }
                        : null,
                    child: Text(
                      'Pay ₹${advanceAmount.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPayButton() {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        final isEnabled = state is PaymentUPISelected;
        final isProcessing = state is PaymentProcessing;
        final advanceAmount = context.read<CartBloc>().state.grandTotal * 0.3;

        return SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isEnabled ? Colors.green.shade800 : Colors.grey.shade400,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: isEnabled && !isProcessing
                ? () {
                    if (state is PaymentUPISelected) {
                      context.read<PaymentBloc>().add(
                            ProcessPayment(state.selectedProvider, advanceAmount),
                          );
                    }
                  }
                : null,
            child: isProcessing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Processing...',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  )
                : Text(
                    'Pay ₹${advanceAmount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade50,
            child: content,
          ),
      ],
    );
  }

  Widget _buildCardOptions() {
    return Text('Card payment options go here');
  }

  Widget _buildNetBankingOptions() {
    return Text('Net banking options go here');
  }
}
