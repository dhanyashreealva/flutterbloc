import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentInitial()) {
    on<SelectUPIProvider>(_onSelectUPIProvider);
    on<ProcessPayment>(_onProcessPayment);
    on<ResetPayment>(_onResetPayment);
  }

  void _onSelectUPIProvider(
    SelectUPIProvider event,
    Emitter<PaymentState> emit,
  ) {
    emit(PaymentUPISelected(event.provider));
  }

  void _onProcessPayment(
    ProcessPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing(event.provider, event.amount));
    
    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    // For demo purposes, we'll assume payment is always successful
    // In a real app, you would integrate with actual payment APIs
    emit(PaymentSuccess(event.provider, event.amount));
    
    // Reset to initial state after showing success
    await Future.delayed(const Duration(seconds: 2));
    emit(const PaymentInitial());
  }

  void _onResetPayment(
    ResetPayment event,
    Emitter<PaymentState> emit,
  ) {
    emit(const PaymentInitial());
  }
}