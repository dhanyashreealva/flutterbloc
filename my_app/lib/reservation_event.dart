import 'package:equatable/equatable.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();
  @override
  List<Object> get props => [];
}

class SelectPeople extends ReservationEvent {
  final String people;
  const SelectPeople(this.people);
  @override
  List<Object> get props => [people];
}

class SelectDate extends ReservationEvent {
  final String date;
  const SelectDate(this.date);
  @override
  List<Object> get props => [date];
}

class SelectTime extends ReservationEvent {
  final String time;
  const SelectTime(this.time);
  @override
  List<Object> get props => [time];
}

class SelectTimeSlot extends ReservationEvent {
  final String slot;
  const SelectTimeSlot(this.slot);
  @override
  List<Object> get props => [slot];
}

class ResetReservation extends ReservationEvent {
  const ResetReservation();
}

class SubmitReservation extends ReservationEvent {
  const SubmitReservation();
}

class LoadTimeSlots extends ReservationEvent {
  const LoadTimeSlots();
}
