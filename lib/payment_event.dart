import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class SelectUPIProvider extends PaymentEvent {
  final String provider;

  const SelectUPIProvider(this.provider);

  @override
  List<Object> get props => [provider];
}

class ProcessPayment extends PaymentEvent {
  final String provider;
  final double amount;

  const ProcessPayment(this.provider, this.amount);

  @override
  List<Object> get props => [provider, amount];
}

class ResetPayment extends PaymentEvent {
  const ResetPayment();
}