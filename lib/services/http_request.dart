import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/utilities/constans.dart';
import 'package:mi_cadena_app/widgets/my_alert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HttpRequest {
  HttpRequest({this.url, this.context, this.body});
  final url;
  final context;
  final body;

  Future post() async {
    try {
      dynamic headers = await getHeaders();
      http.Response response = await http.post(Uri.parse(kServer + url),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode <= 204) {
        String data = response.body;
        showServerResponse(response);
        return jsonDecode(data);
      } else {
        showServerResponse(response);
      }
    } catch (e) {
      print(e);
    }
  }

  Future get() async {
    dynamic headers = await getHeaders();
    http.Response response =
        await http.get(Uri.parse(kServer + url), headers: headers);
    if (response.statusCode <= 204) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      showServerResponse(response);
    }
  }

  Future put() async {
    dynamic headers = await getHeaders();
    http.Response response = await http.put(Uri.parse(kServer + url),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode <= 204) {
      String data = response.body;
      showServerResponse(response);
      return jsonDecode(data);
    } else {
      showServerResponse(response);
    }
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString('token');

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    return headers;
  }

  showServerResponse(response) {
    dynamic data = jsonDecode(response.body);
    int nivel = data['nivel'] == null ? 2 : data['nivel'];
    if (nivel < 3) {
      List<Widget> message = [];
      int statusCode = response.statusCode;
      String titleMessage = '';

      if (statusCode >= 400) {
        titleMessage = "Error";
      } else {
        titleMessage = 'OK';
      }
      message.add(Text(data['message']));

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog(
            title: titleMessage,
            widgetMessage: Column(
              children: message,
            ),
            actions: [
              TextButton(
                child: Text('Cerrar'),
                onPressed: () async {
                  if (statusCode == 401) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('token');
                    context.goNamed('login');
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }
}
