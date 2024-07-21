import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import './add_guests_screen.dart'; // Make sure this path is correct for your project structure

class SelectTimeRangeScreen extends StatefulWidget {
  final String location;

  SelectTimeRangeScreen({Key? key, required this.location}) : super(key: key);

  @override
  _SelectTimeRangeScreenState createState() => _SelectTimeRangeScreenState();
}

class _SelectTimeRangeScreenState extends State<SelectTimeRangeScreen> {
  DateTime? startDate;
  DateTime? endDate;
  CalendarFormat _calendarFormat =
      CalendarFormat.month; // Default to month view

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (startDate == null || endDate != null) {
        startDate = selectedDay;
        endDate = null;
      } else if (endDate == null) {
        endDate = selectedDay;
        if (startDate!.isAfter(endDate!)) {
          DateTime temp = startDate!;
          startDate = endDate;
          endDate = temp;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Range'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: '${widget.location}',
                labelStyle: TextStyle(color: Colors.black),
                border: const OutlineInputBorder(),
                suffixIcon: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2044, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                if (startDate == null) {
                  return false;
                }
                if (endDate == null) {
                  return day.isAtSameMomentAs(startDate!);
                }
                return day.isAtSameMomentAs(startDate!) ||
                    day.isAtSameMomentAs(endDate!) ||
                    (day.isAfter(startDate!) && day.isBefore(endDate!));
              },
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                rangeHighlightColor: Colors.purple,
                rangeStartDecoration:
                    BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
                rangeEndDecoration:
                    BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
                withinRangeDecoration:
                    BoxDecoration(color: Colors.purple.withOpacity(0.5)),
                defaultTextStyle: TextStyle(color: Colors.black),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      startDate = null;
                      endDate = null;
                    });
                  },
                  child: Text('Clear selection'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (startDate != null && endDate != null) {
                      String formattedDateRange =
                          '${DateFormat('yyyy-MM-dd').format(startDate!)} to ${DateFormat('yyyy-MM-dd').format(endDate!)}';
                      // Navigate to AddGuestsScreen with selected dates and location
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddGuestsScreen(
                            dateRange: formattedDateRange,
                            location: widget.location,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a start and end date.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Confirm Dates'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(100, 50),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
