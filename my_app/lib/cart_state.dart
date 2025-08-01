import 'package:equatable/equatable.dart';

enum CartStatus { initial, loading, success, failure }

class CartItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String imagePath;
  final bool isVeg;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.isVeg,
  });

  CartItem copyWith({
    String? id,
    String? name,
    double? price,
    int? quantity,
    String? imagePath,
    bool? isVeg,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imagePath: imagePath ?? this.imagePath,
      isVeg: isVeg ?? this.isVeg,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity, imagePath, isVeg];
}

class CartState extends Equatable {
  final CartStatus status;
  final List<CartItem> cartItems;
  final double itemsTotal;
  final double tax;
  final double grandTotal;
  final String? errorMessage;

  const CartState({
    this.status = CartStatus.initial,
    this.cartItems = const [],
    this.itemsTotal = 0,
    this.tax = 0,
    this.grandTotal = 0,
    this.errorMessage,
  });

  factory CartState.initial() {
    return const CartState(
      status: CartStatus.initial,
      cartItems: [],
      itemsTotal: 0,
      tax: 0,
      grandTotal: 0,
    );
  }

  CartState copyWith({
    CartStatus? status,
    List<CartItem>? cartItems,
    double? itemsTotal,
    double? tax,
    double? grandTotal,
    String? errorMessage,
  }) {
    return CartState(
      status: status ?? this.status,
      cartItems: cartItems ?? this.cartItems,
      itemsTotal: itemsTotal ?? this.itemsTotal,
      tax: tax ?? this.tax,
      grandTotal: grandTotal ?? this.grandTotal,
      errorMessage: errorMessage,
    );
  }

  bool get isEmpty => cartItems.isEmpty;
  int get itemCount => cartItems.length;

  @override
  List<Object?> get props => [
    status,
    cartItems,
    itemsTotal,
    tax,
    grandTotal,
    errorMessage,
  ];
} 