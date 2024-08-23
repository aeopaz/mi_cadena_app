import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/models/user/user_http.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserHttp userHttp = UserHttp();

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _password_confirmation = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name.text = 'Test2';
    _email.text = 'test2@test.com';
    _mobile.text = '3114577230';
    _password.text = '12345678';
    _password_confirmation.text = '12345678';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('La contraseña debe ser mínimo 8 caracteres'),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _name,
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _mobile,
                  decoration: const InputDecoration(
                    labelText: 'Celular',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _password_confirmation,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => _register(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Registrarse'),
                      ),
                isLoading
                    ? SizedBox()
                    : TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Ya tengo una cuenta'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    // Acción de registro
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map data = {
        'name': _name.text,
        'email': _email.text,
        'mobile': _mobile.text,
        'password': _password.text,
        'password_confirmation': _password_confirmation.text
      };
      var response = await userHttp.register(context, data);
      if (response != null) {
        await userHttp.setToken(response);
        context.goNamed('chain');
      }
      setState(() {
        isLoading = false;
      });
    }
  }
}
