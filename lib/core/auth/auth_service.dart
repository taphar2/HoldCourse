import 'package:supabase_flutter/supabase_flutter.dart';

/// The signed-in student, reduced to what the UI needs.
final class AuthSession {
  const AuthSession({required this.email});

  final String email;
}

/// Thrown when the build has no Supabase configuration.
final class AuthUnavailableException implements Exception {
  const AuthUnavailableException();

  String get message =>
      'Cloud sign-in is not configured. Add SUPABASE_URL and '
      'SUPABASE_ANON_KEY as build-time defines.';

  @override
  String toString() => message;
}

/// Authentication operations used by the app and by widget tests.
abstract class AuthService {
  Future<void> initialize();

  Future<AuthSession?> currentSession();

  Stream<AuthSession?> watchSession();

  /// Returns true when Supabase needs email confirmation before sign-in.
  Future<bool> signUp({
    required String email,
    required String password,
    required String studentId,
  });

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();
}

/// Supabase implementation of [AuthService].
final class SupabaseAuthService implements AuthService {
  const SupabaseAuthService({required this.url, required this.anonKey});

  final String url;
  final String anonKey;

  @override
  Future<void> initialize() async {
    await Supabase.initialize(url: url, publishableKey: anonKey);
  }

  AuthSession? _session(Session? session) {
    final String? email = session?.user.email;
    return email == null ? null : AuthSession(email: email);
  }

  @override
  Future<AuthSession?> currentSession() async {
    return _session(Supabase.instance.client.auth.currentSession);
  }

  @override
  Stream<AuthSession?> watchSession() {
    return Supabase.instance.client.auth.onAuthStateChange.map(
      (AuthState state) => _session(state.session),
    );
  }

  @override
  Future<bool> signUp({
    required String email,
    required String password,
    required String studentId,
  }) async {
    final AuthResponse response = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
      data: studentId.isEmpty ? null : {'student_id': studentId},
    );
    return response.session == null;
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }
}

/// Used when a build has no Supabase URL or anon key.
///
/// Authentication stays closed rather than pretending to work offline: all
/// Mode 1 data is tied to the HoldCourse account.
final class UnconfiguredAuthService implements AuthService {
  const UnconfiguredAuthService();

  @override
  Future<void> initialize() async {}

  @override
  Future<AuthSession?> currentSession() async => null;

  @override
  Stream<AuthSession?> watchSession() => const Stream<AuthSession?>.empty();

  @override
  Future<bool> signUp({
    required String email,
    required String password,
    required String studentId,
  }) async {
    throw const AuthUnavailableException();
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    throw const AuthUnavailableException();
  }

  @override
  Future<void> signOut() async {}
}
