import 'dart:convert';
import 'package:mi_cadena_app/services/http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class UserHttp {
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
    // dynamic info = Provider.of<UserProvider>(context, listen: false).userInfo;
    // await pusher.unsubscribe("my-channel");
  }
}
