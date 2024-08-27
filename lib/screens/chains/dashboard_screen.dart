import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/models/chain/chain_http.dart';
import 'package:mi_cadena_app/models/chain/chain_model.dart';
import 'package:mi_cadena_app/store/chain_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ChainHttp chainHttp = ChainHttp();
  List<Chain> listChainsOwn = [];
  List<Chain> listChainsParticipant = [];
  bool isLoading = false;

  @override
  void initState() {
    _getListChain();
    super.initState();
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Text(
                  "Creadas por mi (${listChainsOwn.length})",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(101, 155, 206, 248),
                    child: ListView.builder(
                      itemCount: listChainsOwn
                          .length, // Aquí iría el número de cadenas de ahorro del usuario
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(listChainsOwn[index].name),
                            subtitle: Text(
                                "Finaliza: ${listChainsOwn[index].endDateFormat}"),
                            trailing: Text(listChainsOwn[index].statusText),
                            onTap: () {
                              // Navegar a la pantalla de detalles de la cadena
                              _goTochain(listChainsOwn[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  "Donde yo participo (${listChainsParticipant.length})",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(
                  child: Container(
                    color: const Color.fromARGB(68, 105, 240, 175),
                    child: ListView.builder(
                      itemCount: listChainsParticipant
                          .length, // Aquí iría el número de cadenas de ahorro del usuario
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(listChainsParticipant[index].name),
                            subtitle: Text('Última actividad: Hace 2 días'),
                            onTap: () {
                              // Navegar a la pantalla de detalles de la cadena
                              _goTochain(listChainsParticipant[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
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

  void _getListChain() async {
    setState(() {
      isLoading = true;
    });
    await chainHttp.getList(context);

    final chainProvider = context.read<ChainProvider>();
    setState(() {
      listChainsOwn = chainProvider.listChainsOwn;
      listChainsParticipant = chainProvider.listChainsParticipant;
      isLoading = false;
    });
  }

  void _goTochain(Chain chain) {
    final chainProvider = context.read<ChainProvider>();
    chainProvider.setChain(chain);
    context.goNamed('chain_detail');
  }
}
