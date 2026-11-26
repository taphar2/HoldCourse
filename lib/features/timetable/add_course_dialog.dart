import 'package:material_ui/material_ui.dart';

/// What the student typed into the add-course form.
final class NewCourseDetails {
  const NewCourseDetails({
    required this.code,
    required this.title,
    required this.lecturer,
  });

  final String code;
  final String title;
  final String lecturer;
}

/// Asks for the details of a new course. Returns null when cancelled.
Future<NewCourseDetails?> showAddCourseDialog(BuildContext context) async {
  final TextEditingController code = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController lecturer = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey<FormState>();

  try {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add course'),
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
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return null;
    }
    return NewCourseDetails(
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
