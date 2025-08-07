abstract class ReservationEvent {}

class PartySizeSelected extends ReservationEvent {
  final String partySize;
  PartySizeSelected(this.partySize);
}

class DateSelected extends ReservationEvent {
  final String date;
  DateSelected(this.date);
}

class TimeSelected extends ReservationEvent {
  final String time;
  TimeSelected(this.time);
}

class TimeSlotTapped extends ReservationEvent {
  final String selectedSlot;
  TimeSlotTapped(this.selectedSlot);
}
