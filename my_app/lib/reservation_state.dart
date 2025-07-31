import 'package:equatable/equatable.dart';

class ReservationState extends Equatable {
  final String selectedPeople;
  final String selectedDate;
  final String selectedTime;
  final String selectedSlot;

  const ReservationState({
    this.selectedPeople = '2',
    this.selectedDate = 'today',
    this.selectedTime = '06:00',
    this.selectedSlot = '',
  });

  ReservationState copyWith({
    String? selectedPeople,
    String? selectedDate,
    String? selectedTime,
    String? selectedSlot,
  }) {
    return ReservationState(
      selectedPeople: selectedPeople ?? this.selectedPeople,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedSlot: selectedSlot ?? this.selectedSlot,
    );
  }

  @override
  List<Object> get props => [selectedPeople, selectedDate, selectedTime, selectedSlot];
}
