import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(const ReservationState()) {
    on<SelectPeople>((event, emit) {
      emit(state.copyWith(selectedPeople: event.people));
    });

    on<SelectDate>((event, emit) {
      emit(state.copyWith(selectedDate: event.date));
    });

    on<SelectTime>((event, emit) {
      emit(state.copyWith(selectedTime: event.time));
    });

    on<SelectTimeSlot>((event, emit) {
      emit(state.copyWith(selectedSlot: event.slot));
    });
  }
}
