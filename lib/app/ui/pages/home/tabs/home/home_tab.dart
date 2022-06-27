import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:tasa_interes/app/ui/routes/routes.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
