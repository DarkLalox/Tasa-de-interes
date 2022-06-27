import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasa_interes/app/domain/repositories/account_repository.dart';

class AccountRespositoyImpl implements AccountRepository {
  final FirebaseAuth _auth;

  AccountRespositoyImpl(this._auth);

  @override
  Future<User> updateDisplayName(String value) async {
    final user = _auth.currentUser;
    assert(user != null);
    await user!.updateDisplayName(value);
    return user;
  }
}
