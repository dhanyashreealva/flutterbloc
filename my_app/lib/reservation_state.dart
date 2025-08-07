class ReservationState {
  final String partySize;
  final String date;
  final String time;
  final List<String> timeSlots;
  final String selectedSlot;

  ReservationState({
    required this.partySize,
    required this.date,
    required this.time,
    required this.timeSlots,
    required this.selectedSlot,
  });

  factory ReservationState.initial() {
    return ReservationState(
      partySize: '',
      date: '',
      time: '',
      timeSlots: [],
      selectedSlot: '',
    );
  }

  ReservationState copyWith({
    String? partySize,
    String? date,
    String? time,
    List<String>? timeSlots,
    String? selectedSlot,
  }) {
    return ReservationState(
      partySize: partySize ?? this.partySize,
      date: date ?? this.date,
      time: time ?? this.time,
      timeSlots: timeSlots ?? this.timeSlots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
    );
  }
}
