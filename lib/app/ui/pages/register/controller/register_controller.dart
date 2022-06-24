import 'package:flutter/widgets.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:tasa_interes/app/domain/inputs/sign_up.dart';
import 'package:tasa_interes/app/domain/repositories/sign_up_repository.dart';
import 'package:tasa_interes/app/domain/responses/sign_up_response.dart';
import 'register_state.dart';

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController() : super(RegisterState.initialState);
  final GlobalKey<FormState> formkey = GlobalKey();
  final _signUpRepository = Get.i.find<SignUpRepository>();

  Future<SignUpResponse> submit() {
    return _signUpRepository.register(
      SignUpData(
        name: state.name,
        namepyme: state.namepyme,
        email: state.email,
        password: state.password,
      ),
    );
  }

  void onNameChanged(String text) {
    state = state.copyWith(name: text);
  }

  void onNamePymeChanged(String text) {
    state = state.copyWith(namepyme: text);
  }

  void onEmailChanged(String text) {
    state = state.copyWith(email: text);
  }

  void onPasswordChanged(String text) {
    state = state.copyWith(password: text);
  }

  void onVPasswordChanged(String text) {
    state = state.copyWith(vPassword: text);
  }
}
