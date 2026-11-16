import 'package:flutter_test/flutter_test.dart';
import 'package:hold_course/app.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('home screen renders the empty timetable state', (tester) async {
    await tester.pumpWidget(const HoldCourseApp());

    expect(find.text('HoldCourse'), findsOneWidget);
    expect(find.text('No timetable yet'), findsOneWidget);
  });
}
