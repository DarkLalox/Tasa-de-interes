import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    final SessionController = watch(sessionProvider);
    return Container(
      child: Text("Profile Tab"),
    );
  }
}
