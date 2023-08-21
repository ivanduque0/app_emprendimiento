import 'dart:convert';

import 'package:app_emprendimiento/main/domain/exception/main_exception.dart';
import 'package:app_emprendimiento/main/domain/repositories/api_main_repository.dart';
import 'package:http/http.dart' as http;

class ApiMainImplementation extends ApiMainInterface {
  @override
  Future<Map> getTasas() async {
    try {
      var res = await http.get(Uri.parse('https://pydolarvenezuela-api.vercel.app/api/v1/dollar/dolar_promedio')).timeout(const Duration(seconds: 8));
      Map tasas = await jsonDecode(res.body);
      return tasas;
    } catch (e){
      throw MainErrorConnectionException();
    }
  }
  
}