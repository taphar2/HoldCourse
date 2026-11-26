import 'package:material_ui/material_ui.dart';

/// Human-readable weekday names, using the same numbering as [DateTime].
String weekdayLabel(int weekday) {
  return switch (weekday) {
    DateTime.monday => 'Monday',
    DateTime.tuesday => 'Tuesday',
    DateTime.wednesday => 'Wednesday',
    DateTime.thursday => 'Thursday',
    DateTime.friday => 'Friday',
    DateTime.saturday => 'Saturday',
    DateTime.sunday => 'Sunday',
    _ => throw ArgumentError.value(weekday, 'weekday', 'not a weekday'),
  };
}

/// Minutes since midnight, the way class times are stored.
int minutesOf(TimeOfDay time) => time.hour * 60 + time.minute;

/// Formats stored minutes using the device's 24-hour time convention.
String formatMinutes(BuildContext context, int minutes) {
  return MaterialLocalizations.of(context).formatTimeOfDay(
    TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60),
    alwaysUse24HourFormat: true,
  );
}
