import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasa_interes/app/domain/inputs/sign_up.dart';
import 'package:tasa_interes/app/domain/repositories/sign_up_repository.dart';
import 'package:tasa_interes/app/domain/responses/sign_up_response.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _auth;
  SignUpRepositoryImpl(this._auth);
  @override
  Future<SignUpResponse> register(SignUpData data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );
      await userCredential.user!.updateDisplayName(
        "${data.name} ${data.namepyme}",
      );
      return SignUpResponse(null, userCredential.user!); //ver
    } on FirebaseAuthException catch (e) {
      return SignUpResponse(parseStringToSingUpError(e.code), null);
    }
  }
}
