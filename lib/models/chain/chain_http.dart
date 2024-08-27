import 'package:mi_cadena_app/models/chain/chain_model.dart';
import 'package:mi_cadena_app/services/http_request.dart';
import 'package:mi_cadena_app/store/chain_provider.dart';
import 'package:provider/provider.dart';

class ChainHttp {
  getList(context) async {
    HttpRequest httpRequest =
        HttpRequest(url: '/savings_chains', context: context);
    var decodeData = await httpRequest.get();
    if (decodeData != null) {
      List<Chain> listChainsOwn = [];
      List<Chain> listChainsParticipant = [];

      for (Map<String, dynamic> onw in decodeData['data']['saving_chain_own']) {
        Chain chain = Chain.fromJson(onw);
        listChainsOwn.add(chain);
      }

      for (var part in decodeData['data']['saving_chain_participant']) {
        Chain chain = Chain.fromJson(part);
        listChainsParticipant.add(chain);
      }

      final chainProvider = Provider.of<ChainProvider>(context, listen: false);
      chainProvider.setListChainsOwn(listChainsOwn);
      chainProvider.setListChainsParticipant(listChainsParticipant);
    }
  }
}
