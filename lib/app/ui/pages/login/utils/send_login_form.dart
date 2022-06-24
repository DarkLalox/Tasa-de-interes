import 'package:flutter/cupertino.dart';
import 'package:tasa_interes/app/domain/responses/sign_in_response.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';
import '../login_page.dart' show loginProvider;
import 'package:flutter_meedu/router.dart' as router;

Future<void> sendLoginForm(BuildContext context) async {
  final controller = loginProvider.read;
  final isValidForm = controller.formkey.currentState!.validate();
  if (isValidForm) {
    ProgressDialog.show(context);
    final response = await controller.submit();
    router.pop();
    if (response.error != null) {
      String errorMessage = "";

      switch (response.error) {
        case SignInError.networkRequestFailed:
          errorMessage = "Solicitud de red fallida";
          break;
        case SignInError.userDisabled:
          errorMessage = "Usuario Deshabilitado";
          break;
        case SignInError.userNotFound:
          errorMessage = "Usuario no encontrado";
          break;
        case SignInError.wrongPassword:
          errorMessage = "Contraseña Equivocada";
          break;
        case SignInError.unknown:
        default:
          errorMessage = "Error desconocido";
          break;
      }
      Dialogs.alert(
        context,
        title: "ERROR",
        content: errorMessage,
      );
    } else {
      router.pushReplacementNamed(
        Routes.HOME,
      );
    }
  }
}
