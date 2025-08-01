import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(LoadCart()),
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8), // Light off-white background
        body: SafeArea(
          child: BlocListener<CartBloc, CartState>(
            listenWhen: (previous, current) {
              return (previous.status != current.status) && 
                     (current.status == CartStatus.failure);
            },
            listener: (context, state) {
              if (state.status == CartStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'An error occurred'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: Column(
              children: [
                // Top Header
                _buildHeader(),
                
                // Restaurant Name
                _buildRestaurantName(),
                
                // Cart Items List
                Expanded(
                  child: _buildItemsList(),
                ),
                
                // Bill Details and Next Button
                _buildBillDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
          Expanded(
            child: Text(
              'CART',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Icon(
            Icons.home_outlined,
            color: Colors.black,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantName() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Divider(color: Colors.grey.shade300, height: 1),
          SizedBox(height: 8),
          Text(
            'The Grand Kitchen-Multi Cuisine Restaurant',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
            ),
          );
        }

        if (state.status == CartStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
                SizedBox(height: 16),
                Text(
                  'Failed to load cart items',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(LoadCart());
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                SizedBox(height: 16),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: state.cartItems.length,
          itemBuilder: (context, index) {
            final item = state.cartItems[index];
            return Column(
              children: [
                _buildItemCard(context, item),
                if (index < state.cartItems.length - 1)
                  Divider(color: Colors.grey.shade300, height: 1),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildItemCard(BuildContext context, CartItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          // Food Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12),
          
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Dietary Indicator
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: item.isVeg ? Colors.green : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Quantity Controls
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (item.quantity > 1) {
                        context.read<CartBloc>().add(
                          UpdateItemQuantity(item.id, item.quantity - 1),
                        );
                      } else {
                        context.read<CartBloc>().add(
                          RemoveItemFromCart(item.id),
                        );
                      }
                    },
                    icon: Icon(Icons.remove_circle_outline, size: 20),
                    color: Colors.grey.shade600,
                  ),
                  Text(
                    '${item.quantity}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<CartBloc>().add(
                        UpdateItemQuantity(item.id, item.quantity + 1),
                      );
                    },
                    icon: Icon(Icons.add_circle_outline, size: 20),
                    color: Color(0xFF2E7D32),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                '₹${(item.price * item.quantity).toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetails() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
          ),
          child: Column(
            children: [
              // Bill Details Title
              Row(
                children: [
                  Text(
                    'BILL DETAILS',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Bill Items
              _buildBillRow('Items Total', '₹${state.itemsTotal.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              _buildBillRow('Tax', '₹${state.tax.toStringAsFixed(2)}'),
              Divider(color: Colors.grey.shade300, height: 24),
              _buildBillRow('Grand total', '₹${state.grandTotal.toStringAsFixed(2)}', isTotal: true),
              
              SizedBox(height: 20),
              
              // Next Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32), // Green color
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: state.cartItems.isNotEmpty ? () {
                    // Navigate to next screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Proceeding to checkout...'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } : null,
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? Colors.red : Colors.grey.shade700,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: isTotal ? Colors.red : Colors.grey.shade700,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
} 