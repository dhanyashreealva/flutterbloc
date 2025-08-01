import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.loading));
    
    try {
      // Simulate API call to load cart items
      await Future.delayed(Duration(milliseconds: 500));
      
      // Mock cart data
      final cartItems = [
        CartItem(
          id: '1',
          name: 'Chicken Manchow Soup',
          price: 502.50,
          quantity: 2,
          imagePath: 'assets/images/soup.jpg',
          isVeg: false,
        ),
        CartItem(
          id: '2',
          name: 'Veg biriyani',
          price: 160.75,
          quantity: 1,
          imagePath: 'assets/images/biryani.jpg',
          isVeg: true,
        ),
        CartItem(
          id: '3',
          name: 'Paneer manchurian',
          price: 280.25,
          quantity: 1,
          imagePath: 'assets/images/paneer.jpg',
          isVeg: true,
        ),
        CartItem(
          id: '4',
          name: 'Ghee rice',
          price: 180.00,
          quantity: 2,
          imagePath: 'assets/images/rice.jpg',
          isVeg: true,
        ),
        CartItem(
          id: '5',
          name: 'Chicken Kadai',
          price: 640.20,
          quantity: 2,
          imagePath: 'assets/images/chicken.jpg',
          isVeg: false,
        ),
      ];

      final itemsTotal = cartItems.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));
      final tax = itemsTotal * 0.06; // 6% tax
      final grandTotal = itemsTotal + tax;

      emit(state.copyWith(
        status: CartStatus.success,
        cartItems: cartItems,
        itemsTotal: itemsTotal,
        tax: tax,
        grandTotal: grandTotal,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to load cart: $e',
      ));
    }
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    final existingItemIndex = state.cartItems.indexWhere((item) => item.id == event.item.id);
    
    if (existingItemIndex != -1) {
      // Item already exists, update quantity
      final updatedItems = List<CartItem>.from(state.cartItems);
      final existingItem = updatedItems[existingItemIndex];
      updatedItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.item.quantity,
      );
      
      _updateCartTotals(emit, updatedItems);
    } else {
      // Add new item
      final updatedItems = [...state.cartItems, event.item];
      _updateCartTotals(emit, updatedItems);
    }
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.where((item) => item.id != event.itemId).toList();
    _updateCartTotals(emit, updatedItems);
  }

  void _onUpdateItemQuantity(UpdateItemQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems.map((item) {
      if (item.id == event.itemId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();
    
    _updateCartTotals(emit, updatedItems);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(
      cartItems: [],
      itemsTotal: 0,
      tax: 0,
      grandTotal: 0,
    ));
  }

  void _updateCartTotals(Emitter<CartState> emit, List<CartItem> items) {
    final itemsTotal = items.fold<double>(0, (sum, item) => sum + (item.price * item.quantity));
    final tax = itemsTotal * 0.06; // 6% tax
    final grandTotal = itemsTotal + tax;

    emit(state.copyWith(
      cartItems: items,
      itemsTotal: itemsTotal,
      tax: tax,
      grandTotal: grandTotal,
    ));
  }
} 