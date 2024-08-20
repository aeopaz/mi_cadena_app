import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/models/user/user_http.dart';
import 'package:mi_cadena_app/services/http_request.dart';
import 'package:mi_cadena_app/widgets/my_alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserHttp userHttp = UserHttp();
  String _email = "";
  String _password = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) => _email = value,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) => _password = value,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => _validateForm() ? _login() : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Iniciar Sesión'),
                    ),
              if (_isLoading == false)
                TextButton(
                  onPressed: () {
                    // Navegar a pantalla de registro
                    context.go('/register');
                  },
                  child: const Text('Registrarse'),
                ),
              if (_isLoading == false)
                TextButton(
                  onPressed: () {
                    // Navegar a pantalla de recuperación de contraseña
                    context.go('/forgot_password');
                  },
                  child: const Text('Olvidé mi Contraseña'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  _login() async {
    setState(() {
      _isLoading = true;
    });
    // Acción de iniciar sesión
    var response = await userHttp.login(
        context: context, email: _email, password: _password);

    if (response != null) {
      // ignore: use_build_context_synchronously
      context.goNamed('dashboard');
      await userHttp.setToken(response);
    }
    setState(() {
      _isLoading = false;
    });
  }

  bool _validateForm() {
    return _email != '' && _password != '';
  }
}
