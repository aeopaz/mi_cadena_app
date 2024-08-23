import 'package:flutter/material.dart';
import 'package:mi_cadena_app/routes/routes.dart';
import 'package:mi_cadena_app/theme/theme.dart';

void main() {
  runApp(MiCadenaApp());
}

class MiCadenaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Mi Cadena',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: myTheme);
  }
}
