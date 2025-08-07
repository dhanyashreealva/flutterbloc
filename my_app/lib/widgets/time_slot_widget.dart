import 'package:flutter/material.dart';

class TimeSlotWidget extends StatelessWidget {
  final String time;
  final String selected;
  final VoidCallback onTap;

  const TimeSlotWidget({required this.time, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isSelected = time == selected;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
