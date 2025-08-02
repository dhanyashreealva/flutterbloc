import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_confirmation_event.dart';
import 'reservation_confirmation_state.dart';

class ReservationConfirmationBloc extends Bloc<ReservationConfirmationEvent, ReservationConfirmationState> {
  ReservationConfirmationBloc() : super(const ReservationConfirmationState()) {
    on<LoadReservationConfirmation>(_onLoad);
    on<AddContactInfo>(_onAddContactInfo);
    on<ProceedToPay>(_onProceedToPay);
  }

  void _onLoad(LoadReservationConfirmation event, Emitter<ReservationConfirmationState> emit) async {
    emit(state.copyWith(status: ReservationConfirmationStatus.loading));
    try {
      // Simulate loading reservation confirmation data
      await Future.delayed(Duration(milliseconds: 500));
      
      // Generate a confirmation number (in a real app, this would come from the backend)
      final confirmationNumber = 'CONF-${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
      
      emit(state.copyWith(
        status: ReservationConfirmationStatus.success,
        confirmationNumber: confirmationNumber,
      ));
    } catch (e) {
      emit(state.copyWith(status: ReservationConfirmationStatus.failure, errorMessage: e.toString()));
    }
  }

  void _onAddContactInfo(AddContactInfo event, Emitter<ReservationConfirmationState> emit) {
    emit(state.copyWith(contactInfo: event.contactInfo));
  }

  void _onProceedToPay(ProceedToPay event, Emitter<ReservationConfirmationState> emit) {
    // Implement payment logic here
  }
}
