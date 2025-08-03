import 'package:equatable/equatable.dart';

abstract class OrderSummaryEvent extends Equatable {
  const OrderSummaryEvent();

  @override
  List<Object?> get props => [];
}

class LoadOrderSummary extends OrderSummaryEvent {}

class RefreshOrderSummary extends OrderSummaryEvent {}
