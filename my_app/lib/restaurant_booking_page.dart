import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class RestaurantBookingPage extends StatelessWidget {
  final List<String> partySizes = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+'];
  final List<String> dates = ['today', 'tomorrow', 'day after tomorrow'];
  final List<String> times = [
    '05:00 PM', '05:30 PM', '06:00 PM', '06:30 PM',
    '07:00 PM', '07:30 PM', '08:00 PM', '09:30 PM'
  ];
final disabledSlots = ['05:00 PM','07:00 PM', '08:00 PM'];
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
                    color: const Color.fromRGBO(226, 161, 70, 1),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.arrow_back),
                            Spacer(),
                            Icon(Icons.home_outlined),
                          ],
                        ),
                        const Text(
                          "The Grand Kitchen-Multi Cuisine",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Text("North-Indian Restaurant"),
                        const SizedBox(height: 20),

                        // Row for dropdowns
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Party size dropdown
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: state.partySize.isNotEmpty ? state.partySize : null,
                                  underline: const SizedBox(),
                                  hint: const Text("party"),
                                   alignment: Alignment.center,
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
                              ),
                            ),

                            // Day dropdown
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: state.date.isNotEmpty ? state.date : null,
                                  underline: const SizedBox(),
                                  hint: const Text("day"),
                                   alignment: Alignment.center,
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
                              ),
                            ),

                            // Time dropdown
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400),
                              ),
                              child: SizedBox(
                                height: 40,
                                child: DropdownButton<String>(
                                  isDense: true,
                                  value: state.time.isNotEmpty ? state.time : null,
                                  underline: const SizedBox(),
                                  hint: const Text("time"),
                                   alignment: Alignment.center,
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Available time slots section
                  if (state.timeSlots.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Available time slots:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: state.timeSlots.map((slot) {
                        final isSelected = slot == state.selectedSlot;
                        final isDisabled = disabledSlots.contains(slot);
                        return GestureDetector(
                          onTap: isDisabled ? null
                          :() => bloc.add(TimeSlotTapped(slot)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration( 
                              color: isDisabled ?
                               Colors.grey.shade200 // light grey background for disabled
                              : isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(10), // pill shape
                              border: Border.all(
                                color: isSelected ? Colors.black : Colors.grey.shade400,
                              ),
                            ),
                            child: Text(
                              slot,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: state.selectedSlot.isNotEmpty
                              ? Colors.green.shade800
                              : Colors.green.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 2,
                        ),
                        onPressed: state.selectedSlot.isNotEmpty ? () {Navigator.pushNamed(context, '/Tableselection');} : null,
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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
