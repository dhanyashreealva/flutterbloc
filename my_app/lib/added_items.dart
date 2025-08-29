import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class AdditemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(LoadCart()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(child: _buildItemsList()),
              _buildBottomButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // 
//   
Widget _buildHeader(BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 12),
      SizedBox(
        height: 50, // fixed height for header bar
        child: Stack(
          children: [
            // Back Arrow (Top Left)
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/confirmation'),
                child: const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 32),
                ),
              ),
            ),

            // Center Title
            Center(
              child: Text(
                'ADDED ITEMS',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Home Icon (Top Right)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/booking'),
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.home_outlined, color: Colors.black, size: 32),
                ),
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Container(
          width: 350,
          height: 1,
          color: Colors.black,
        ),
      ),
    ],
  );
}

  Widget _buildItemsList() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.status == CartStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state.cartItems.isEmpty) {
          return Center(
            child: Text('Your cart is empty',
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: state.cartItems.length,
          separatorBuilder: (_, __) => Divider(color: Colors.grey.shade300),
          itemBuilder: (context, index) {
            final item = state.cartItems[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imagePath,
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('₹${item.price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    item.isVeg
                        ? _buildVegIcon()
                        : _buildNonVegIcon(),
                    SizedBox(height: 6),
                    Text(
                      "Quantity: ${item.quantity.toString().padLeft(2, '0')}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildVegIcon() {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        ),
      ),
    );
  }

  Widget _buildNonVegIcon() {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Center(
        child: CustomPaint(size: Size(9, 9), painter: _RedTrianglePainter()),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          padding: EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/MenuPage');
        },
        child: Text(
          "ADD ITEMS",
          style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _RedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.red;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
