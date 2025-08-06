import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';
//import 'TableSelectionPage.dart';
import 'CartPage.dart';


class RestaurantBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFFB97A3B), // Exact color: #F8E6E6
        body: SafeArea(
          child: BlocListener<ReservationBloc, ReservationState>(
            listenWhen: (previous, current) {
              return (previous.status != current.status) && 
                     (current.status == ReservationStatus.success || 
                      current.status == ReservationStatus.failure);
            },
            listener: (context, state) {
              if (state.status == ReservationStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reservation submitted successfully!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                Future.delayed(Duration(seconds: 3), () {
                  // Navigate to the confirmation page with the confirmation number
                  Navigator.pushNamed(
                    context, 
                    '/confirmation',
                    arguments: state.confirmationNumber,
                  );
                  context.read<ReservationBloc>().add(ResetReservation());
                });
              } else if (state.status == ReservationStatus.failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage ?? 'An error occurred'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 3),
                  ),
                );
              }
            },
            child: _buildMainContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        // Orange Container with Restaurant Header and Booking Details
        Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          decoration: BoxDecoration(
            color: Color(0xFFD8923C), // Light orange/brownish-orange
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Restaurant Header
              _buildRestaurantHeader(),
              
              // Booking Details Section
              _buildBookingDetails(),
            ],
          ),
        ),
        
        // Gap between orange container and time slots
        SizedBox(height: 16),
        
        // Time Slots Section (outside orange container)
        Expanded(
          child: _buildTimeSlots(),
        ),
        
        // Next Button (outside orange container)
        _buildNextButton(),
      ],
    );
  }

  Widget _buildRestaurantHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 24,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'The Grand Kitchen-Multi Cuisine',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'North-Indian Restaurant',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.home_outlined,
                color: Colors.black,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown('People', _peopleOptions, 'selectedPeople'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildDropdown('Date', _dateOptions, 'selectedDate'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildDropdown('Time', _timeOptions, 'selectedTime'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Available time slots:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> options, String stateKey) {
    return BlocBuilder<ReservationBloc, ReservationState>(
      builder: (context, state) {
        String currentValue = '';
        
        switch (stateKey) {
          case 'selectedPeople':
            currentValue = state.selectedPeople;
            break;
          case 'selectedDate':
            currentValue = state.selectedDate;
            break;
          case 'selectedTime':
            currentValue = state.selectedTime;
            break;
        }

        return Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue.isNotEmpty ? currentValue : null,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
                size: 18,
              ),
              dropdownColor: Colors.white,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              hint: Text(
                label,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  switch (stateKey) {
                    case 'selectedPeople':
                      context.read<ReservationBloc>().add(SelectPeople(newValue));
                      break;
                    case 'selectedDate':
                      context.read<ReservationBloc>().add(SelectDate(newValue));
                      break;
                    case 'selectedTime':
                      context.read<ReservationBloc>().add(SelectTime(newValue));
                      break;
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimeSlots() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<ReservationBloc, ReservationState>(
                  builder: (context, state) {
                    if (state.status == ReservationStatus.loading && state.availableTimeSlots.isEmpty) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C42)),
                        ),
                      );
                    }
              
                    if (state.status == ReservationStatus.failure && state.availableTimeSlots.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48,
                              color: Colors.red,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Failed to load time slots',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ReservationBloc>().add(LoadTimeSlots());
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    final timeSlots = state.availableTimeSlots.isNotEmpty 
                        ? state.availableTimeSlots 
                        : _timeSlots;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: timeSlots.length,
                      itemBuilder: (context, index) {
                        final timeSlot = timeSlots[index];
                        final isSelected = state.selectedSlot == timeSlot;
                        final isBooked = state.isTimeSlotBooked(timeSlot);
                        
                        return GestureDetector(
                          onTap: isBooked ? null : () {
                            context.read<ReservationBloc>().add(
                              SelectTimeSlot(timeSlot),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isBooked 
                                  ? Colors.white // White background for booked slots (as per image)
                                  : isSelected 
                                      ? Colors.black 
                                      : Colors.white,
                              border: Border.all(
                                color: isBooked 
                                    ? Colors.grey.shade400 
                                    : Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                timeSlot,
                                style: TextStyle(
                                  color: isBooked 
                                      ? Colors.grey.shade600 
                                      : isSelected 
                                          ? Colors.white 
                                          : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      padding: EdgeInsets.all(16),
      child: BlocBuilder<ReservationBloc, ReservationState>(
        builder: (context, state) {
          final isFormValid = state.isFormValid;
          final isLoading = state.status == ReservationStatus.loading;
          
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFormValid 
                    ? Color(0xFF2E7D32) // Dark green when enabled
                    : Color(0xFF81C784), // Light green when disabled
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: isFormValid && !isLoading ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                   builder: (context) => CartPage(),
                  ),
                );
              } : null,
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Processing...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  // Available time slots (fallback)
  final List<String> _timeSlots = [
    '05:00 PM',
    '05:30 PM',
    '06:00 PM',
    '06:30 PM',
    '07:00 PM',
    '07:30 PM',
    '08:00 PM',
    '09:30 PM',
  ];

  // Dropdown options
  final List<String> _peopleOptions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10+',
  ];

  final List<String> _dateOptions = [
    'today',
    'tomorrow',
    'day after tomorrow',
    'next week',
  ];

  final List<String> _timeOptions = [
    '06:00',
    '06:30',
    '07:00',
    '07:30',
    '08:00',
    '08:30',
    '09:00',
    '09:30',
  ];
} 