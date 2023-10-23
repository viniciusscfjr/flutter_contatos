import 'package:dio/dio.dart';
import 'package:flutter_contatos/models/contatos_back4app_model.dart';

class ContatosBack4AppRepository {
  ContatosBack4AppRepository();

  Future<ContatosBack4AppModel> listar() async {
    var url = "https://parseapi.back4app.com/classes/contatos";

    var dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["X-Parse-Application-Id"] =
        "9PdgXLEAVtvu9bX9TBeSCZiUS2054PYKrtkXZtyy";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "pABIsnKg24vaHOTc2n3Y7y5F40IjljELFRU6HMUr";

    var result = await dio.get(url);
    return ContatosBack4AppModel.fromJson(result.data);
  }

  Future<void> criar(String nome, String path) async {
    var dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["X-Parse-Application-Id"] =
        "9PdgXLEAVtvu9bX9TBeSCZiUS2054PYKrtkXZtyy";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "pABIsnKg24vaHOTc2n3Y7y5F40IjljELFRU6HMUr";

    try {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['name'] = nome;
      data['path'] = path;

      await dio.post("https://parseapi.back4app.com/classes/contatos",
          data: data);
    } catch (e) {
      rethrow;
    }
  }
}
