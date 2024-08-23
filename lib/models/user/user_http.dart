import 'package:mi_cadena_app/services/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHttp {
  Future<dynamic> register(context, Map data) async {
    HttpRequest httpRequest =
        HttpRequest(url: '/user', context: context, body: data);

    var decodeData = await httpRequest.post();

    return decodeData;
  }

  Future<dynamic> requestTokenEmail(context, Map data) async {
    HttpRequest httpRequest = HttpRequest(
        url: '/user/send_code_verify_user_email', context: context, body: data);

    var decodeData = await httpRequest.post();

    return decodeData;
  }

  //Obtener token para iniciar sesión
  Future<dynamic> login({context, email, password}) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };
    HttpRequest httpRequest =
        HttpRequest(url: '/auth/login', context: context, body: body);

    var decodeData = await httpRequest.post();

    return decodeData;
  }

//Almacenar el token en el dispositivo
  Future<dynamic> setToken(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic dataUser = data['data'];
    dynamic user = dataUser['user'];
    prefs.setStringList('userInfo', [
      user['id'].toString(),
      user['name'],
      user['email'],
      user['email_verified'],
    ]);
    prefs.setString('token', dataUser['token']);
  }

  //Obtener los datos del usuario autenticado
  Future<dynamic> getUser() async {
    HttpRequest httpRequest = HttpRequest(url: '/get_user_data');
    var decodeData = await httpRequest.get();
    return decodeData;
  }

  //Cerrar sesión
  Future<dynamic> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userInfo');
    return true;
    // dynamic info = Provider.of<UserProvider>(context, listen: false).userInfo;
    // await pusher.unsubscribe("my-channel");
  }

  Future<dynamic> getLocalUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('userInfo');
  }

  Future<dynamic> getLocalToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
