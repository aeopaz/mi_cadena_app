import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavingsChainDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la Cadena'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Acción para regresar
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Nombre de la Cadena'),
                subtitle: Text('Detalles generales de la cadena'),
              ),
            ),
            SizedBox(height: 16),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Participantes'),
                subtitle: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          child: Text('P$index'),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Número de aportaciones en la cadena
                itemBuilder: (context, index) {
                  var aport = index + 1;
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: ListTile(
                      title: Text('Aportación ${aport}'),
                      subtitle: Text('Monto: \$${(aport) * 100}'),
                      trailing: TextButton(
                        child: Text(aport % 2 == 0 ? "Reversar" : "Confirmar"),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                // Acción para salir de la cadena
                context.pop();
              },
              child: Text('Salir de la Cadena'),
            ),
          ],
        ),
      ),
    );
  }
}
