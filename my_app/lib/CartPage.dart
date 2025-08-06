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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<CartBloc, CartState>(
            listenWhen: (previous, current) =>
                (previous.status != current.status) && (current.status == CartStatus.failure),
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
                _buildHeader(context),
                _buildRestaurantName(),
                Expanded(child: _buildItemsList()),
                _buildBillDetails(),
              ],
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
            child: Icon(Icons.arrow_back, color: Colors.black, size: 24),
          ),
          Expanded(
            child: Text(
              'ADDED ITEMS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed('/'),
            child: Icon(Icons.home_outlined, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }

  /// 🔧 EDITED SECTION: Centered line under restaurant name
  Widget _buildRestaurantName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Text(
            'The Grand Kitchen–Multi Cuisine Restaurant',
            style: TextStyle(
              color: Colors.brown.shade400,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Center(
            child: Container(
              width: 280,
              height: 1,
              color: Colors.grey.shade400,
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
                Icon(Icons.error_outline, size: 48, color: Colors.red),
                SizedBox(height: 16),
                Text('Failed to load cart items',
                    style: TextStyle(fontSize: 16, color: Colors.red)),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.read<CartBloc>().add(LoadCart()),
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
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade400),
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

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: state.cartItems.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: 1),
          itemBuilder: (context, index) {
            final item = state.cartItems[index];
            return _buildItemCard(context, item);
          },
        );
      },
    );
  }

  Widget _buildItemCard(BuildContext context, CartItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 4),
                Text('₹${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    )),
              ],
            ),
          ),
          item.isVeg
              ? Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.green, width: 2),
                  ),
                  child: Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                )
              : Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.red, width: 2),
                  ),
                  child: Center(
                    child: CustomPaint(
                      size: Size(10, 10),
                      painter: _RedTrianglePainter(),
                    ),
                  ),
                ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Quantity: ${item.quantity.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )),
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
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('BILL DETAILS',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 16),
              _buildBillRow('Items Total', '₹${state.itemsTotal.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              _buildBillRow('Tax', '₹${state.tax.toStringAsFixed(2)}'),
              Divider(color: Colors.grey.shade300, height: 24),
              _buildBillRow('Grand total', '₹${state.grandTotal.toStringAsFixed(2)}',
                  isTotal: true),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: state.cartItems.isNotEmpty
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Proceeding to checkout...'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
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

class _RedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
