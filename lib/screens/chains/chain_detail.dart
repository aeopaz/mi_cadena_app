import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/utilities/constans.dart';
import 'package:provider/provider.dart';
import 'package:mi_cadena_app/models/chain/chain_model.dart';
import 'package:mi_cadena_app/store/chain_provider.dart';

class SavingsChainDetailsScreen extends StatefulWidget {
  @override
  State<SavingsChainDetailsScreen> createState() =>
      _SavingsChainDetailsScreenState();
}

class _SavingsChainDetailsScreenState extends State<SavingsChainDetailsScreen> {
  late Chain _chain;
  Map _participant = {};
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getChain();
    super.initState();
  }

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
      body: isLoading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _chainDetail(),
                  SizedBox(height: 16),
                  _listParticipants(),
                  SizedBox(height: 16),
                  _participant.isEmpty
                      ? const SizedBox(height: 16)
                      : _listContributions(),
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

  Expanded _listContributions() {
    return Expanded(
      child: ListView.builder(
        itemCount: _participant['contributions']
            .length, // Número de aportaciones en la cadena
        itemBuilder: (context, index) {
          var contribution = _participant['contributions'][index];
          var aport = index + 1;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              title: Text(
                  'Cuota No. ${aport} - ${contribution['estimated_contribution_date']}'),
              subtitle: Text('Monto: ' +
                  kNumberFormat.format(double.parse(contribution['amount']))),
              trailing: TextButton(
                child: Text(aport % 2 == 0 ? "Reversar" : "Confirmar"),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

  Card _listParticipants() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text('Participantes'),
        subtitle: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(_chain.participants.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    _setParticipant(_chain.participants[index]);
                  },
                  child: CircleAvatar(
                    child: Text(_getNameInitials(
                        _chain.participants[index]['user_info']['name'])),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Card _chainDetail() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(_chain.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text("Inicia: ${_chain.startDateFormat}"),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text("Finaliza: ${_chain.endDateFormat}"),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. Participanetes estimados:'),
                Text(_chain.participantCount.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. Participanetes Reales'),
                Text(_chain.participants.length.toString()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Aporte a la fecha'),
                Text(kNumberFormat.format(_chain.totalContributionsPaid)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pendiente'),
                Text(kNumberFormat.format(_chain.totalContributionsOwed)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('No. Participantes atrazados'),
                Text(_chain.lateParticipants.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _getChain() {
    setState(() {
      isLoading = true;
    });
    final chainProvider = context.read<ChainProvider>();
    _chain = chainProvider.chain;
    setState(() {
      isLoading = false;
    });
  }

  void _setParticipant(Map participant) {
    setState(() {
      _participant = participant;
    });
    // final chainProvider = context.read<ChainProvider>();
    // chainProvider.setParticipant(participant);
  }

  // void _getParticipant(Map participant) {
  //   final chainProvider = context.read<ChainProvider>();
  //   _participant = chainProvider.participant;
  // }

  String _getNameInitials(name) {
    return name[0] + name[1].toUpperCase();
  }
}
