import 'package:material_ui/material_ui.dart';

import '../../core/auth/auth_service.dart';

/// Email/password sign-in and sign-up for Mode 1.
class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.auth,
    required this.onAuthenticated,
  });

  final AuthService auth;

  /// Called after a sign-in, or after a sign-up that does not need email
  /// confirmation, so the app can re-read the active session.
  final VoidCallback onAuthenticated;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _studentId = TextEditingController();
  bool _signUp = false;
  bool _busy = false;
  String? _error;
  String? _message;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _studentId.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) {
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
      _message = null;
    });

    String? error;
    String? message;
    bool authenticated = false;
    try {
      if (_signUp) {
        final bool needsConfirmation = await widget.auth.signUp(
          email: _email.text.trim(),
          password: _password.text,
          studentId: _studentId.text.trim(),
        );
        if (needsConfirmation) {
          message = 'Check your email to confirm your account, then sign in.';
        } else {
          authenticated = true;
        }
      } else {
        await widget.auth.signIn(
          email: _email.text.trim(),
          password: _password.text,
        );
        authenticated = true;
      }
    } on AuthUnavailableException catch (exception) {
      error = exception.message;
    } catch (exception) {
      error = 'Unable to continue. $exception';
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
      _message = message;
    });
    if (authenticated) {
      widget.onAuthenticated();
    }
  }

  void _toggleMode() {
    setState(() {
      _signUp = !_signUp;
      _error = null;
      _message = null;
      _form.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(_signUp ? 'Create account' : 'Sign in')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('HoldCourse', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 8),
                Text(
                  'Track your own timetable, attendance and CATs.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  key: const Key('auth-email-field'),
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (String? value) {
                    final String email = value?.trim() ?? '';
                    if (!email.contains('@') || email.startsWith('@')) {
                      return 'Enter a valid email address.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key('auth-password-field'),
                  controller: _password,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (String? value) {
                    if (value == null || value.length < 6) {
                      return 'Use at least 6 characters.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                if (_signUp) ...[
                  const SizedBox(height: 12),
                  TextFormField(
                    key: const Key('auth-student-id-field'),
                    controller: _studentId,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your student ID.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                      helperText: 'For your reference. It is not verified.',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                if (_busy)
                  Semantics(
                    label: 'Signing in',
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  FilledButton(
                    key: const Key('auth-submit'),
                    onPressed: _submit,
                    child: Text(_signUp ? 'Create account' : 'Sign in'),
                  ),
                const SizedBox(height: 12),
                TextButton(
                  key: const Key('auth-toggle'),
                  onPressed: _busy ? null : _toggleMode,
                  child: Text(
                    _signUp
                        ? 'Already have an account? Sign in'
                        : 'Need an account? Sign up',
                  ),
                ),
                if (_message != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _message!,
                    key: const Key('auth-message'),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    key: const Key('auth-error'),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
