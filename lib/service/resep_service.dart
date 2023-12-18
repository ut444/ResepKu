import 'package:dio/dio.dart';
import '../model/api_client.dart';
import '../model/resep.dart';

class ResepService {
  Future<List<Resep>> listData() async {
    final Response response = await ApiClient().get('recipe');
    final List data = response.data as List;
    List<Resep> result = data.map((json) => Resep.fromJson(json)).toList();
    return result;
  }

  Future<Resep> simpan(Resep resep) async {
    var data = resep.toJson();
    final Response response = await ApiClient().post('recipe', data);
    Resep result = Resep.fromJson(response.data);
    return result;
  }

  Future<Resep> ubah(Resep resep, String id) async {
    var data = resep.toJson();
    final Response response = await ApiClient().put('recipe/${id}', data);
    print(response);
    Resep result = Resep.fromJson(response.data);
    return result;
  }

  Future<Resep> getById(String id) async {
    final Response response = await ApiClient().get('recipe/${id}');
    Resep result = Resep.fromJson(response.data);
    return result;
  }

  Future<Resep> hapus(Resep poli) async {
    final Response response = await ApiClient().delete('recipe/${poli.id}');
    Resep result = Resep.fromJson(response.data);
    return result;
  }
}
