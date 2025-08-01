import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reservation_bloc.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class RestaurantBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationBloc()..add(LoadTimeSlots()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<ReservationBloc, ReservationState>(
            listenWhen: (previous, current) {
              // Only listen when status changes to success or failure
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
                // Reset the status after showing the message
                Future.delayed(Duration(seconds: 3), () {
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
            child: Column(
              children: [
                // Header Section
                _buildHeader(),
                
                // Booking Details Section
                _buildBookingDetails(),
                
                // Time Slots Section
                Expanded(
                  child: _buildTimeSlots(),
                ),
                
                // Next Button
                _buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFF8C42), // Light brown/orange color
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Grand Kitchen-Multi Cuisine',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'North-Indian Restaurant',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.home,
            color: Colors.white,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetails() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Row(
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
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFFFF8C42),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: currentValue.isNotEmpty ? currentValue : null,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 20,
              ),
              dropdownColor: Color(0xFFFF8C42),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              hint: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available time slots:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<ReservationBloc, ReservationState>(
              builder: (context, state) {
                if (state.status == ReservationStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C42)),
                    ),
                  );
                }

                if (state.status == ReservationStatus.failure) {
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
                    
                    return GestureDetector(
                      onTap: () {
                        context.read<ReservationBloc>().add(
                          SelectTimeSlot(timeSlot),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
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
        ],
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
                context.read<ReservationBloc>().add(SubmitReservation());
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