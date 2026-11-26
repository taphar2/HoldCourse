import 'package:material_ui/material_ui.dart';

/// What the student typed into the course form.
final class CourseFormResult {
  const CourseFormResult({
    required this.code,
    required this.title,
    required this.lecturer,
  });

  final String code;
  final String title;
  final String lecturer;
}

/// Asks for course details, prefilled when [initial] is given.
///
/// Returns null when cancelled. The caller decides whether this is a new
/// course or an edit; changing an existing course never rewrites attendance.
Future<CourseFormResult?> showCourseDialog(
  BuildContext context, {
  CourseFormResult? initial,
}) async {
  final TextEditingController code = TextEditingController(text: initial?.code);
  final TextEditingController title = TextEditingController(
    text: initial?.title,
  );
  final TextEditingController lecturer = TextEditingController(
    text: initial?.lecturer,
  );
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final bool editing = initial != null;

  try {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(editing ? 'Edit course' : 'Add course'),
          content: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: code,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(labelText: 'Course code'),
                    validator: (String? value) =>
                        value == null || value.trim().isEmpty
                        ? 'Enter a course code'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      labelText: 'Course title',
                    ),
                    validator: (String? value) =>
                        value == null || value.trim().isEmpty
                        ? 'Enter a course title'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: lecturer,
                    decoration: const InputDecoration(
                      labelText: 'Lecturer (optional)',
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (form.currentState!.validate()) {
                  Navigator.of(context).pop(true);
                }
              },
              child: Text(editing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return null;
    }
    return CourseFormResult(
      code: code.text.trim(),
      title: title.text.trim(),
      lecturer: lecturer.text.trim(),
    );
  } finally {
    code.dispose();
    title.dispose();
    lecturer.dispose();
  }
}
