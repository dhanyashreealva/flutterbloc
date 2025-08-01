import 'package:equatable/equatable.dart';

enum ReservationStatus { initial, loading, success, failure }

class ReservationState extends Equatable {
  final String selectedPeople;
  final String selectedDate;
  final String selectedTime;
  final String selectedSlot;
  final ReservationStatus status;
  final String? errorMessage;
  final List<String> availableTimeSlots;
  final bool isFormValid;

  const ReservationState({
    this.selectedPeople = '2',
    this.selectedDate = 'today',
    this.selectedTime = '06:00',
    this.selectedSlot = '',
    this.status = ReservationStatus.initial,
    this.errorMessage,
    this.availableTimeSlots = const [],
    this.isFormValid = false,
  });

  ReservationState copyWith({
    String? selectedPeople,
    String? selectedDate,
    String? selectedTime,
    String? selectedSlot,
    ReservationStatus? status,
    String? errorMessage,
    List<String>? availableTimeSlots,
    bool? isFormValid,
  }) {
    return ReservationState(
      selectedPeople: selectedPeople ?? this.selectedPeople,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      status: status ?? this.status,
      errorMessage: errorMessage,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }

  bool get isTimeSlotSelected => selectedSlot.isNotEmpty;
  bool get isAllFieldsSelected => selectedPeople.isNotEmpty && 
                                selectedDate.isNotEmpty && 
                                selectedTime.isNotEmpty && 
                                selectedSlot.isNotEmpty;

  @override
  List<Object?> get props => [
    selectedPeople, 
    selectedDate, 
    selectedTime, 
    selectedSlot, 
    status, 
    errorMessage,
    availableTimeSlots,
    isFormValid,
  ];
}
