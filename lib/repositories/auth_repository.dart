import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  User? get currentUser => _client.auth.currentUser;
  Session? get currentSession => _client.auth.currentSession;
  Stream<AuthState> get onAuthStateChange => _client.auth.onAuthStateChange;

  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> signOutEverywhere() async {
    await _client.auth.signOut(scope: SignOutScope.global);
  }

  Future<UserResponse> updateUser({
    String? email,
    String? password,
    Map<String, dynamic>? data,
  }) async {
    return await _client.auth.updateUser(
      UserAttributes(
        email: email,
        password: password,
        data: data,
      ),
    );
  }

  Future<AuthMFAEnrollResponse> enrollMFA() async {
    return await _client.auth.mfa.enroll(factorType: FactorType.totp);
  }

  Future<AuthMFAVerifyResponse> verifyMFA({
    required String factorId,
    required String code,
  }) async {
    final challenge = await _client.auth.mfa.challenge(factorId: factorId);
    return await _client.auth.mfa.verify(
      factorId: factorId,
      challengeId: challenge.id,
      code: code,
    );
  }

  Future<List<Map<String, dynamic>>> getActiveSessions() async {
    final data = await _client.rpc('get_my_sessions');
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> deleteAccount() async {
    await _client.rpc('delete_my_account');
  }
}
