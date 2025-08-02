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

class SelectCardOption extends PaymentEvent {
  final String cardOption;

  const SelectCardOption(this.cardOption);

  @override
  List<Object> get props => [cardOption];
}

class SelectNetBankingOption extends PaymentEvent {
  final String netBankingOption;

  const SelectNetBankingOption(this.netBankingOption);

  @override
  List<Object> get props => [netBankingOption];
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
