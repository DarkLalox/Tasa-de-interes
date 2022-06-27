import 'package:flutter/material.dart';
import 'package:flutter_meedu/meedu.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:flutter_meedu/state.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';
import 'package:tasa_interes/app/ui/global_widgets/custom_input_field.dart';
import 'package:tasa_interes/app/ui/pages/login/controller/login_controller.dart';
import 'package:tasa_interes/app/ui/pages/login/utils/send_login_form.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';
import 'package:tasa_interes/app/utils/email.validator.dart';

final loginProvider = SimpleProvider(
  (_) => LoginController(sessionProvider.read),
);

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //MediaQuery.of(context).size;
    //MediaQuery.of(context).padding.bottom;
    //final height =context.height;
    return ProviderListener<LoginController>(
      provider: loginProvider,
      builder: (_, controller) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: controller.formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //SvgPicture.asset(
                      //  'assets/images/light/Graphic_Welcome.svg',
                      //  width: 200,
                      //),
                      //const SizedBox(height: 30), cambiar
                      CustomInpudField(
                        label: "Correo electrónico",
                        onChanged: controller.onEmailChanged,
                        inputType: TextInputType.emailAddress,
                        validator: (text) {
                          if (isValidEmail(text!)) {
                            return null;
                          }
                          return "El Correo electrónico es inválido";
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomInpudField(
                        label: "Contraseña",
                        onChanged: controller.onPasswordChanged,
                        isPassword: true,
                        validator: (text) {
                          if (text!.trim().length >= 6) {
                            return null;
                          }
                          return "La contraseña es inválida";
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () =>
                                router.pushNamed(Routes.RESET_PASSWORD),
                            child: const Text("¿Olvidaste tu contraseña?"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => sendLoginForm(context),
                            child: const Text("Iniciar sesión"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => router.pushNamed(Routes.REGISTER),
                        child: const Text("Registrarse"),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
