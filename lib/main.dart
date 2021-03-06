import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasa_interes/app/inject_dependencies.dart';

import 'app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  injectDependencies();
  runApp(
    const MyApp(),
  );
}
