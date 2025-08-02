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
  final List<String> bookedTimeSlots;
  final bool isFormValid;
  final String? confirmationNumber;

  const ReservationState({
    this.selectedPeople = '2',
    this.selectedDate = 'today',
    this.selectedTime = '06:00',
    this.selectedSlot = '',
    this.status = ReservationStatus.success,
    this.errorMessage,
    this.availableTimeSlots = const [
      '05:00 PM',
      '05:30 PM',
      '06:00 PM',
      '06:30 PM',
      '07:00 PM',
      '07:30 PM',
      '08:00 PM',
      '09:30 PM',
    ],
    this.bookedTimeSlots = const [
      '05:00 PM',
      '07:00 PM',
      '08:00 PM',
    ],
    this.isFormValid = false,
    this.confirmationNumber,
  });

  ReservationState copyWith({
    String? selectedPeople,
    String? selectedDate,
    String? selectedTime,
    String? selectedSlot,
    ReservationStatus? status,
    String? errorMessage,
    List<String>? availableTimeSlots,
    List<String>? bookedTimeSlots,
    bool? isFormValid,
    String? confirmationNumber,
  }) {
    return ReservationState(
      selectedPeople: selectedPeople ?? this.selectedPeople,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      status: status ?? this.status,
      errorMessage: errorMessage,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
      bookedTimeSlots: bookedTimeSlots ?? this.bookedTimeSlots,
      isFormValid: isFormValid ?? this.isFormValid,
      confirmationNumber: confirmationNumber ?? this.confirmationNumber,
    );
  }

  bool get isTimeSlotSelected => selectedSlot.isNotEmpty;
  bool get isAllFieldsSelected => selectedPeople.isNotEmpty && 
                                selectedDate.isNotEmpty && 
                                selectedTime.isNotEmpty && 
                                selectedSlot.isNotEmpty;

  bool isTimeSlotBooked(String timeSlot) {
    return bookedTimeSlots.contains(timeSlot);
  }

  @override
  List<Object?> get props => [
    selectedPeople, 
    selectedDate, 
    selectedTime, 
    selectedSlot, 
    status, 
    errorMessage,
    availableTimeSlots,
    bookedTimeSlots,
    isFormValid,
    confirmationNumber,
  ];
}
