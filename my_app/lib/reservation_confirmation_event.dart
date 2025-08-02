import 'package:equatable/equatable.dart';

abstract class ReservationConfirmationEvent extends Equatable {
  const ReservationConfirmationEvent();

  @override
  List<Object?> get props => [];
}

class LoadReservationConfirmation extends ReservationConfirmationEvent {}

class AddContactInfo extends ReservationConfirmationEvent {
  final String contactInfo;

  const AddContactInfo(this.contactInfo);

  @override
  List<Object?> get props => [contactInfo];
}

class ProceedToPay extends ReservationConfirmationEvent {}
