import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_summary_event.dart';
import 'order_summary_state.dart';
import 'cart_bloc.dart';

class OrderSummaryBloc extends Bloc<OrderSummaryEvent, OrderSummaryState> {
  final CartBloc cartBloc;

  OrderSummaryBloc({required this.cartBloc}) : super(const OrderSummaryState()) {
    on<LoadOrderSummary>(_onLoadOrderSummary);
    on<RefreshOrderSummary>(_onRefreshOrderSummary);
  }

  void _onLoadOrderSummary(
      LoadOrderSummary event, Emitter<OrderSummaryState> emit) async {
    emit(state.copyWith(status: OrderSummaryStatus.loading));

    try {
      // Simulate fetching order summary data
      await Future.delayed(Duration(seconds: 1));

      // For demonstration, using dynamic data from CartState if available
      // Otherwise fallback to static data
      final cartState = cartBloc.state;
      final itemsTotal = cartState.itemsTotal ?? 0.0;
      final tax = cartState.tax ?? 0.0;
      final grandTotal = cartState.grandTotal ?? 0.0;
      final amountPaid = grandTotal * 0.3;
      final balanceAmount = grandTotal - amountPaid;

      emit(state.copyWith(
        status: OrderSummaryStatus.success,
        bookingId: '062816AT258181',
        tableNumber: '06',
        bookingDate: 'Sunday 15 June',
        bookingTime: '07:00 PM IST',
        partySize: 2,
        itemsTotal: itemsTotal,
        tax: tax,
        grandTotal: grandTotal,
        amountPaid: amountPaid,
        balanceAmount: balanceAmount,
        statusMessage: 'CONFIRMED',
      ));
    } catch (e) {
      emit(state.copyWith(
          status: OrderSummaryStatus.failure,
          errorMessage: 'Failed to load order summary'));
    }
  }

  void _onRefreshOrderSummary(
      RefreshOrderSummary event, Emitter<OrderSummaryState> emit) async {
    // For simplicity, just reload the order summary
    add(LoadOrderSummary());
  }
}
