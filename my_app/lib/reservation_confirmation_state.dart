import 'package:equatable/equatable.dart';

enum ReservationConfirmationStatus { initial, loading, success, failure }

class ReservationConfirmationState extends Equatable {
  final ReservationConfirmationStatus status;
  final String? contactInfo;
  final String? errorMessage;

  const ReservationConfirmationState({
    this.status = ReservationConfirmationStatus.initial,
    this.contactInfo,
    this.errorMessage,
  });

  ReservationConfirmationState copyWith({
    ReservationConfirmationStatus? status,
    String? contactInfo,
    String? errorMessage,
  }) {
    return ReservationConfirmationState(
      status: status ?? this.status,
      contactInfo: contactInfo ?? this.contactInfo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, contactInfo, errorMessage];
}
