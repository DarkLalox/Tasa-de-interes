import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';
import 'package:flutter_meedu/router.dart' as router;
import 'package:tasa_interes/app/ui/global_widgets/dialogs/dialogs.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/progress_dialog.dart';
import 'package:tasa_interes/app/ui/global_widgets/dialogs/show_input_dialog.dart';
import 'package:tasa_interes/app/ui/routes/routes.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);

  void _updateDisplayName(BuildContext context) async {
    final sessionController = sessionProvider.read;
    final value = await showInputDialog(
      context,
      initialValue: sessionController.user!.displayName ?? '',
    );
    if (value != null) {
      ProgressDialog.show(context);
      final user = await sessionController.updateDisplayName(value);
      Navigator.pop(context);
      if (user == null) {
        Dialogs.alert(
          context,
          title: "Error",
          content: "Verifica tu conexión a internet",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, watch) {
    final sessionController = watch(sessionProvider);
    final user = sessionController.user!;
    final displayName = user.displayName ?? '';
    final letter = displayName.isNotEmpty ? displayName[0] : "";
    return ListView(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 75,
          child: user.photoURL == null
              ? Text(
                  letter,
                  style: const TextStyle(fontSize: 65),
                )
              : null,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(
          displayName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )),
        Center(child: Text(user.email ?? '')),
        const SizedBox(height: 20),
        //const Text("Datos del Usuario"),
        LabelButton(
          label: "Nombre",
          value: (displayName),
          onPressed: () => _updateDisplayName(context),
        ),
        LabelButton(
          label: "Nombre de la PYME",
          value: displayName,
          onPressed: () {},
        ),
        LabelButton(
          label: "Correo electrónico",
          value: user.email ?? '',
          onPressed: () {},
        ),
        LabelButton(
          label: "Correo electrónico verificado",
          value: user.emailVerified ? "YES" : "NO",
          onPressed: () {},
        ),
        LabelButton(
          label: "Cerrar sesión",
          value: "",
          onPressed: () async {
            await sessionProvider.read.signOut();
            router.pushNamedAndRemoveUntil(Routes.LOGIN);
          },
        ),
      ],
    );
  }
}

class LabelButton extends StatelessWidget {
  final String label, value;
  final VoidCallback? onPressed;
  const LabelButton({
    Key? key,
    required this.label,
    required this.value,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      leading: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w300),
          ),
          const SizedBox(width: 5),
          Icon(
            Icons.chevron_right_rounded,
            size: 22,
            color: onPressed != null ? Colors.black45 : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
