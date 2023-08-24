import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFF828690),
          width: 0.5,
        ),
      ),
      child: TableCalendar(
        // daysOfWeekStyle: DaysOfWeekStyle(
        //     weekdayStyle: TextStyle(color: Colors.white),
        //     weekendStyle: TextStyle(color: Colors.white),
        //     decoration: BoxDecoration(
        //       color: Color(0xFF828690),
        //     )),
        headerStyle: HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
          titleTextStyle: const TextStyle(
              color: Color(
                0xFF828690,
              ),
              fontSize: 16,
              fontWeight: FontWeight.w600),
          leftChevronIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0)),
            child: Icon(
              Icons.chevron_left,
              color: Colors.blue.shade600,
            ),
          ),
          rightChevronIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0)),
            child: Icon(
              Icons.chevron_right,
              color: Colors.blue.shade600,
            ),
          ),
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarFormat: CalendarFormat.month,
        focusedDay: DateTime.now(),
        firstDay: DateTime.now().subtract(const Duration(days: 365 * 50)),
        lastDay: DateTime.now().add(const Duration(days: 365 * 50)),
      ),
    );
  }
}
