import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/widgets/my_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    _checkVerifyEmail();
    super.initState();
  }

  _checkVerifyEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userInfo = prefs.getStringList('userInfo');

    if (userInfo![3] == 'n') {
      print(userInfo);
      MyAlertDialog(
          title: 'Advertencia',
          widgetMessage: Text('Debe verificar su email'),
          actions: () => {context.goNamed('verify_email')});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Cadena'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Acción para notificaciones
              context.goNamed('notifications');
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Acción para perfil
              context.goNamed('profile');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Aquí iría el número de cadenas de ahorro del usuario
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Cadena de Ahorro ${index + 1}'),
              subtitle: Text('Última actividad: Hace 2 días'),
              onTap: () {
                // Navegar a la pantalla de detalles de la cadena
                context.goNamed('chain_detail');
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para crear nueva cadena
          context.goNamed('create_chain');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
