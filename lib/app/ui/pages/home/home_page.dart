// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:tasa_interes/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';
import '../../../tmp_graphic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (_, watch, __) {
                final user = watch(sessionProvider).user!;
                List<String> splitName = user.displayName!.split(" ");
                return Text(splitName.first);
              },
            ),
            Text("Gráfico TPM"),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                  height: 350.0,
                  width: 350.0,
                  child: SimpleTimeSeriesChart.withSampleData()),
            ),
            const SizedBox(height: 100),
            CupertinoButton(
              color: Colors.blue,
              child: Text("Cerrar sesión"),
              onPressed: () async {
                await sessionProvider.read.signOut();
                router.pushNamedAndRemoveUntil(Routes.LOGIN);
              },
            )
          ],
        ),
      ),
    );
  }
}
