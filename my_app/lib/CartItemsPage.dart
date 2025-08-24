import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_bloc.dart';
import 'cart_state.dart';

class CartItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<CartBloc>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black,size: 36),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'FOOD ITEMS',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home_outlined, color: Colors.black,size: 36),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false),
            ),
          ],
        ),

       
        body: SafeArea(
          child: Column(
            children: [
              Center(
          child: Container(
              width: 350, 
            child: Divider(
             color: Colors.black,
             thickness: 1,
             height: 5,
              ),
              ),
              ),
              Expanded(
                child: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state?.status == CartStatus.loading) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
                        ),
                      );
                    }
                    if (state?.status == CartStatus.failure) {
                      return Center(
                        child: Text(state?.errorMessage ?? 'Failed to load cart items'),
                      );
                    }
                    if (state?.cartItems == null || state!.cartItems.isEmpty) {
                      return Center(
                        child: Text('No items in cart'),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: state.cartItems.length,
                      separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300, height: 1),
                      itemBuilder: (context, index) {
                        final item = state.cartItems[index];
                        return _buildItemCard(item);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // ✅ CHANGED ENDS HERE
      ),
    );
  }

  Widget _buildItemCard(CartItem item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Food Image
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
          // Item Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '₹${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Veg/Non-Veg Indicator
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
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
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
          // Quantity
          Text(
            'Quantity: ${item.quantity.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
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
