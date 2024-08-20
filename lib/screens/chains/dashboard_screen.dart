import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
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
