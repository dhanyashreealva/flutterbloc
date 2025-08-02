import 'package:equatable/equatable.dart';

enum ReservationConfirmationStatus { initial, loading, success, failure }

class ReservationConfirmationState extends Equatable {
  final ReservationConfirmationStatus status;
  final String? contactInfo;
  final String? errorMessage;
  final String? confirmationNumber;

  const ReservationConfirmationState({
    this.status = ReservationConfirmationStatus.initial,
    this.contactInfo,
    this.errorMessage,
    this.confirmationNumber,
  });

  ReservationConfirmationState copyWith({
    ReservationConfirmationStatus? status,
    String? contactInfo,
    String? errorMessage,
    String? confirmationNumber,
  }) {
    return ReservationConfirmationState(
      status: status ?? this.status,
      contactInfo: contactInfo ?? this.contactInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      confirmationNumber: confirmationNumber ?? this.confirmationNumber,
    );
  }

  @override
  List<Object?> get props => [status, contactInfo, errorMessage, confirmationNumber];
}
