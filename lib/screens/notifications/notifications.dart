import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: ListView.builder(
        itemCount: 10, // Número de notificaciones
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notification_important),
            title: Text('Notificación ${index + 1}'),
            subtitle: Text('Hace ${index + 1} días'),
            trailing:
                Icon(Icons.circle, color: Colors.red), // Indicador de no leído
          );
        },
      ),
    );
  }
}
