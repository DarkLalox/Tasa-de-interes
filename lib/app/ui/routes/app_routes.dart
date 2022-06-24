import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart' show BuildContext, Widget;
import 'package:tasa_interes/app/ui/pages/home/home_page.dart';
import 'package:tasa_interes/app/ui/pages/login/login_page.dart';
import 'package:tasa_interes/app/ui/pages/register/register_page.dart';
import 'package:tasa_interes/app/ui/pages/reset_password/reset_password_page.dart';
import 'package:tasa_interes/app/ui/pages/splash/splash_page.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes => {
      Routes.SPLASH: (_) => const SplashPage(),
      Routes.LOGIN: (_) => const LoginPage(),
      Routes.HOME: (_) => const HomePage(),
      Routes.REGISTER: (_) => const RegisterPage(),
      Routes.RESET_PASSWORD: (_) => const ResetPasswordPage(),
    };
