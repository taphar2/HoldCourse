import 'dart:async';

import 'package:hold_course/core/auth/auth_service.dart';

/// In-memory [AuthService] for widget tests.
final class FakeAuthService implements AuthService {
  FakeAuthService({this._session});

  AuthSession? _session;
  final StreamController<AuthSession?> _sessions =
      StreamController<AuthSession?>.broadcast();

  String? signedInEmail;
  String? signedUpEmail;
  String? signedUpStudentId;
  bool signedOut = false;

  bool get isSignedIn => _session != null;

  @override
  Future<void> initialize() async {}

  @override
  Future<AuthSession?> currentSession() async => _session;

  @override
  Stream<AuthSession?> watchSession() => _sessions.stream;

  @override
  Future<bool> signUp({
    required String email,
    required String password,
    required String studentId,
  }) async {
    signedUpEmail = email;
    signedUpStudentId = studentId;
    _session = AuthSession(email: email);
    _sessions.add(_session);
    return false;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    signedInEmail = email;
    _session = AuthSession(email: email);
    _sessions.add(_session);
  }

  @override
  Future<void> signOut() async {
    signedOut = true;
    _session = null;
    _sessions.add(null);
  }

  void dispose() {
    _sessions.close();
  }
}

FakeAuthService signedInAuth() {
  return FakeAuthService(
    session: const AuthSession(email: 'student@example.com'),
  );
}
