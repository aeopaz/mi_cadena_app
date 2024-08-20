import 'package:flutter/material.dart';
import 'package:mi_cadena_app/routes/routes.dart';

void main() {
  runApp(MiCadenaApp());
}

class MiCadenaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(router);
    return MaterialApp.router(
      title: 'Mi Cadena',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
