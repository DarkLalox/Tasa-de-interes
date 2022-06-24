import 'package:flutter/material.dart';
import 'package:tasa_interes/app/domain/responses/sign_up_response.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';
import '../register_page.dart' show registerProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendRegisterForm(BuildContext context) async {
  final controller = registerProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();

  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      late String content;
      switch (response.error) {
        case SignUpError.emailAlreadyInUse:
          content = "El correo ya está en uso";
          break;
        case SignUpError.weakPassword:
          content = "Contraseña débil";
          break;
        case SignUpError.networkRequestFailed:
          content = "Solicitud de red fallida";
          break;
        case SignUpError.unknown:
        default:
          content = "ERROR desconocido";
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: content,
      );
    } else {
      router.pushNamedAndRemoveUntil(
        Routes.HOME,
      );
    }
  } else {
    Dialogs.alert(
      context,
      title: "ERROR",
      content: "Campos Inválidos",
    );
  }
}
