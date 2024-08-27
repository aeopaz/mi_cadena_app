import 'package:flutter/material.dart';
import 'package:mi_cadena_app/models/chain/chain_model.dart';

class ChainProvider with ChangeNotifier {
  late List<Chain> _listChainsOwn = [];
  late List<Chain> _listChainsParticipant = [];
  late Chain _chain = {} as Chain;
  late Map _participant = {};

  List<Chain> get listChainsOwn => _listChainsOwn;
  List<Chain> get listChainsParticipant => _listChainsParticipant;
  Chain get chain => _chain;
  Map get participant => _participant;

  void setListChainsOwn(List<Chain> listChainsOwn) {
    _listChainsOwn = listChainsOwn;
    notifyListeners();
  }

  void setListChainsParticipant(List<Chain> listChainsParticipant) {
    _listChainsParticipant = listChainsParticipant;
    notifyListeners();
  }

  void setChain(Chain chain) {
    _chain = chain;
  }

  void setParticipant(Map participant) {
    _participant = participant;
  }
}
