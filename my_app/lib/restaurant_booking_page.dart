import 'package:flutter/material.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';
import 'widgets/time_slot_widget.dart';


class RestaurantBookingPage extends StatelessWidget {
  final List<String> partySizes = ['1', '2', '3', '4', '5','6','7','8','9','10+'];
  final List<String> dates = ['today', 'tomorrow','day after tomorrow'];
  final List<String> times = ['05:00 PM', '05:30 PM', '06:00 PM','6:30 PM','7:00 PM','7:30 PM','8:00 PM','9:30 PM'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReservationBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              final bloc = context.read<ReservationBloc>();

              return Column(
                children: [
                  Container(
                    color: Color.fromRGBO(226, 161, 70, 1),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.arrow_back),
                            Spacer(),
                            Icon(Icons.home),
                          ],
                        ),
                        const Text(
                          "The Grand Kitchen-Multi Cuisine",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Text("North-Indian Restaurant"),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                              hint: const Text("party"),
                              value: state.partySize.isNotEmpty ? state.partySize : null,
                              items: partySizes.map((size) {
                                return DropdownMenuItem(
                                  value: size,
                                  child: Text(size),
                                );
                              }).toList(),
                              onChanged: (value) {
                                bloc.add(PartySizeSelected(value!));
                              },
                            ),
                            DropdownButton(
                              hint: const Text("date"),
                              value: state.date.isNotEmpty ? state.date : null,
                              items: dates.map((date) {
                                return DropdownMenuItem(
                                  value: date,
                                  child: Text(date),
                                );
                              }).toList(),
                              onChanged: (value) {
                                bloc.add(DateSelected(value!));
                              },
                            ),
                            DropdownButton(
                              hint: const Text("time"),
                              value: state.time.isNotEmpty ? state.time : null,
                              items: times.map((time) {
                                return DropdownMenuItem(
                                  value: time,
                                  child: Text(time),
                                );
                              }).toList(),
                              onChanged: (value) {
                                bloc.add(TimeSelected(value!));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state.timeSlots.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Available time slots:"),
                    ),
                    Wrap(
                      children: state.timeSlots.map((slot) {
                        return TimeSlotWidget(
                          time: slot,
                          selected: state.selectedSlot,
                          onTap: () {
                            bloc.add(TimeSlotTapped(slot));
                          },
                        );
                      }).toList(),
                    ),
                  ],
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.selectedSlot.isNotEmpty ? Colors.green : Colors.green[200],
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: state.selectedSlot.isNotEmpty ? () {} : null,
                      child: const Text("NEXT"),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
