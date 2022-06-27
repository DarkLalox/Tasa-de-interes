import 'package:flutter/material.dart';
import 'package:flutter_meedu/state.dart';
import 'package:tasa_interes/app/ui/global_controllers/session_controller.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, watch) {
    final sessionController = watch(sessionProvider);
    final user = sessionController.user!;
    List<String> splitName = user.displayName!.split(" ");
    return ListView(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 75,
          child: user.photoURL == null
              ? Text(
                  user.displayName![0],
                  style: const TextStyle(fontSize: 65),
                )
              : null,
          backgroundImage:
              user.photoURL != null ? NetworkImage(user.photoURL!) : null,
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(
          splitName.first,
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
          value: splitName.first,
          onPressed: () {},
        ),
        LabelButton(
          label: "Nombre de la PYME",
          value: splitName.last,
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
