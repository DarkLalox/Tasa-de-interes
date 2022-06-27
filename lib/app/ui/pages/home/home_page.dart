// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
//import 'package:tasa_interes/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';
import 'package:tasa_interes/app/ui/pages/home/home_controller.dart';
import 'package:tasa_interes/app/ui/pages/home/tabs/home/home_tab.dart';
import 'package:tasa_interes/app/ui/pages/home/tabs/profile/profile_tab.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';
import '../../../tmp_graphic.dart';

final homeProvider = SimpleProvider(
  (_) => HomeController(),
);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<HomeController>(
      provider: homeProvider,
      builder: (_, controller) {
        return Scaffold(
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                HomeTab(),
                ProfileTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
