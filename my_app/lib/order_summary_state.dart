import 'package:equatable/equatable.dart';

enum OrderSummaryStatus { initial, loading, success, failure }

class OrderSummaryState extends Equatable {
  final OrderSummaryStatus status;
  final String? bookingId;
  final String? tableNumber;
  final String? bookingDate;
  final String? bookingTime;
  final int? partySize;
  final double? itemsTotal;
  final double? tax;
  final double? grandTotal;
  final double? amountPaid;
  final double? balanceAmount;
  final String? statusMessage;
  final String? errorMessage;

  const OrderSummaryState({
    this.status = OrderSummaryStatus.initial,
    this.bookingId,
    this.tableNumber,
    this.bookingDate,
    this.bookingTime,
    this.partySize,
    this.itemsTotal,
    this.tax,
    this.grandTotal,
    this.amountPaid,
    this.balanceAmount,
    this.statusMessage,
    this.errorMessage,
  });

  OrderSummaryState copyWith({
    OrderSummaryStatus? status,
    String? bookingId,
    String? tableNumber,
    String? bookingDate,
    String? bookingTime,
    int? partySize,
    double? itemsTotal,
    double? tax,
    double? grandTotal,
    double? amountPaid,
    double? balanceAmount,
    String? statusMessage,
    String? errorMessage,
  }) {
    return OrderSummaryState(
      status: status ?? this.status,
      bookingId: bookingId ?? this.bookingId,
      tableNumber: tableNumber ?? this.tableNumber,
      bookingDate: bookingDate ?? this.bookingDate,
      bookingTime: bookingTime ?? this.bookingTime,
      partySize: partySize ?? this.partySize,
      itemsTotal: itemsTotal ?? this.itemsTotal,
      tax: tax ?? this.tax,
      grandTotal: grandTotal ?? this.grandTotal,
      amountPaid: amountPaid ?? this.amountPaid,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      statusMessage: statusMessage ?? this.statusMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        bookingId,
        tableNumber,
        bookingDate,
        bookingTime,
        partySize,
        itemsTotal,
        tax,
        grandTotal,
        amountPaid,
        balanceAmount,
        statusMessage,
        errorMessage,
      ];
}
