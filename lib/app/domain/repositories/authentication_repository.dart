import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasa_interes/app/domain/responses/reset_password_response.dart';
import 'package:tasa_interes/app/domain/responses/sign_in_response.dart';

abstract class AuthenticationRepository {
  Future<User?> get user;
  Future<void> signOut();
  Future<SignInResponse> signInWithEmailandPassword(
    String email,
    String password,
  );

  Future<ResetPasswordResponse?> sendResetPasswordLink(String email);
}
