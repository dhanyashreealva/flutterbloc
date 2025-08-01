import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(const ReservationState()) {
    on<SelectPeople>(_onSelectPeople);
    on<SelectDate>(_onSelectDate);
    on<SelectTime>(_onSelectTime);
    on<SelectTimeSlot>(_onSelectTimeSlot);
    on<ResetReservation>(_onResetReservation);
    on<SubmitReservation>(_onSubmitReservation);
    on<LoadTimeSlots>(_onLoadTimeSlots);
  }

  void _onSelectPeople(SelectPeople event, Emitter<ReservationState> emit) {
    emit(state.copyWith(
      selectedPeople: event.people,
      isFormValid: _validateForm(event.people, state.selectedDate, state.selectedTime, state.selectedSlot),
    ));
  }

  void _onSelectDate(SelectDate event, Emitter<ReservationState> emit) {
    emit(state.copyWith(
      selectedDate: event.date,
      isFormValid: _validateForm(state.selectedPeople, event.date, state.selectedTime, state.selectedSlot),
    ));
  }

  void _onSelectTime(SelectTime event, Emitter<ReservationState> emit) {
    emit(state.copyWith(
      selectedTime: event.time,
      isFormValid: _validateForm(state.selectedPeople, state.selectedDate, event.time, state.selectedSlot),
    ));
  }

  void _onSelectTimeSlot(SelectTimeSlot event, Emitter<ReservationState> emit) {
    emit(state.copyWith(
      selectedSlot: event.slot,
      isFormValid: _validateForm(state.selectedPeople, state.selectedDate, state.selectedTime, event.slot),
    ));
  }

  void _onResetReservation(ResetReservation event, Emitter<ReservationState> emit) {
    // Reset only the status and error message, keep the form data
    emit(state.copyWith(
      status: ReservationStatus.initial,
      errorMessage: null,
    ));
  }

  void _onSubmitReservation(SubmitReservation event, Emitter<ReservationState> emit) async {
    if (!state.isAllFieldsSelected) {
      emit(state.copyWith(
        status: ReservationStatus.failure,
        errorMessage: 'Please fill all required fields',
      ));
      return;
    }

    emit(state.copyWith(status: ReservationStatus.loading));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      emit(state.copyWith(
        status: ReservationStatus.success,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReservationStatus.failure,
        errorMessage: 'Failed to submit reservation: ${e.toString()}',
      ));
    }
  }

  void _onLoadTimeSlots(LoadTimeSlots event, Emitter<ReservationState> emit) async {
    emit(state.copyWith(status: ReservationStatus.loading));

    try {
      // Simulate loading time slots from API
      await Future.delayed(const Duration(milliseconds: 500));
      
      final timeSlots = [
        '05:00 PM',
        '05:30 PM',
        '06:00 PM',
        '06:30 PM',
        '07:00 PM',
        '07:30 PM',
        '08:00 PM',
        '09:30 PM',
      ];

      emit(state.copyWith(
        availableTimeSlots: timeSlots,
        status: ReservationStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ReservationStatus.failure,
        errorMessage: 'Failed to load time slots: ${e.toString()}',
      ));
    }
  }

  bool _validateForm(String people, String date, String time, String slot) {
    return people.isNotEmpty && 
           date.isNotEmpty && 
           time.isNotEmpty && 
           slot.isNotEmpty;
  }
}
