import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasa_interes/app/domain/responses/reset_password_response.dart';
import 'package:tasa_interes/app/ui/global_widgets/custom_input_field.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tasa_interes/app/ui/pages/reset_password/controller/reset_password_controller.dart';
import 'package:tasa_interes/app/utils/email.validator.dart';

final resetPasswordProvider = SimpleProvider(
  (_) => ResetPasswordController(),
);

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<ResetPasswordController>(
      provider: resetPasswordProvider,
      builder: (_, controller) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/images/light/ForgetPassword.svg',
                    width: 200,
                  ),
                  CustomInpudField(
                    label: "Correo electrónico",
                    onChanged: controller.onEmailChanged,
                    inputType: TextInputType.emailAddress,
                  ),
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: const Text("Enviar"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    final controller = resetPasswordProvider.read;
    if (isValidEmail(controller.email)) {
      ProgressDialog.show(context);
      final response = await controller.submit();
      if (response == ResetPasswordResponse.ok) {
        Dialogs.alert(
          context,
          title: "Correo Correcto",
          content: "Correo electrónico enviado",
        );
      } else {
        String errorMessage = "";
        switch (response) {
          case ResetPasswordResponse.networkRequestFailed:
            errorMessage = "Solicitud de red fallida";
            break;
          case ResetPasswordResponse.userDisabled:
            errorMessage = "Usuario deshabilitado";
            break;
          case ResetPasswordResponse.userNotFound:
            errorMessage = "Usuario no encontrado";
            break;
          case ResetPasswordResponse.tooManyRequest:
            errorMessage = "Demaciadas peticiones";
            break;
          case ResetPasswordResponse.unknown:
          default:
            errorMessage = "Error desconocido";
            break;
        }
        Dialogs.alert(
          context,
          title: "ERROR",
          content: errorMessage,
        );
      }
      Navigator.pop(context);
    } else {
      Dialogs.alert(context, content: "Correo electrónico inválido");
    }
  }
}
