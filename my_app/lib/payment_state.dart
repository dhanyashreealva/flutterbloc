import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentUPISelected extends PaymentState {
  final String selectedProvider;

  const PaymentUPISelected(this.selectedProvider);

  @override
  List<Object> get props => [selectedProvider];
}

class PaymentCardSelected extends PaymentState {
  final String selectedCardOption;

  const PaymentCardSelected(this.selectedCardOption);

  @override
  List<Object> get props => [selectedCardOption];
}

class PaymentNetBankingSelected extends PaymentState {
  final String selectedNetBankingOption;

  const PaymentNetBankingSelected(this.selectedNetBankingOption);

  @override
  List<Object> get props => [selectedNetBankingOption];
}

class PaymentProcessing extends PaymentState {
  final String provider;
  final double amount;

  const PaymentProcessing(this.provider, this.amount);

  @override
  List<Object> get props => [provider, amount];
}

class PaymentSuccess extends PaymentState {
  final String provider;
  final double amount;

  const PaymentSuccess(this.provider, this.amount);

  @override
  List<Object> get props => [provider, amount];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}
