import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/models/user/user_http.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List userInfo = ['', '', ''];
  @override
  void initState() {
    getInfoUser();
    super.initState();
  }

  void getInfoUser() async {
    UserHttp userHttp = UserHttp();
    userInfo = await userHttp.getLocalUserInfo();
    setState(() {
      userInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/images/user_profile.png'), // Imagen de perfil
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                userInfo[1],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                userInfo[2],
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar Perfil'),
              onTap: () {
                // Acción para editar perfil
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Cambiar Contraseña'),
              onTap: () {
                // Acción para cambiar contraseña
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notificaciones'),
              onTap: () {
                // Acción para gestionar notificaciones
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                // Acción para cerrar sesión
                UserHttp userHttp = UserHttp();
                var respose = await userHttp.logout();
                if (respose) {
                  context.goNamed('login');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
