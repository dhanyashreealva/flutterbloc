import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc() : super(ReservationState.initial()) {
    on<PartySizeSelected>((event, emit) {
      emit(state.copyWith(partySize: event.partySize));
      _checkAndUpdateSlots(emit);
    });

    on<DateSelected>((event, emit) {
      emit(state.copyWith(date: event.date));
      _checkAndUpdateSlots(emit);
    });

    on<TimeSelected>((event, emit) {
      emit(state.copyWith(time: event.time));
      _checkAndUpdateSlots(emit);
    });

    on<TimeSlotTapped>((event, emit) {
      emit(state.copyWith(
        selectedSlot: event.selectedSlot,
        time: event.selectedSlot,
      ));
    });
  }

  void _checkAndUpdateSlots(Emitter<ReservationState> emit) {
    if (state.partySize.isNotEmpty && state.date.isNotEmpty && state.time.isNotEmpty) {
      emit(state.copyWith(timeSlots: _getTimeSlots()));
    }
  }

  List<String> _getTimeSlots() {
    return [
      "05:00 PM",
      "05:30 PM",
      "06:00 PM",
      "06:30 PM",
      "07:00 PM",
      "07:30 PM",
      "08:00 PM",
      "09:30 PM",
    ];
  }
}
