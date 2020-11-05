import 'package:dio/dio.dart';

import '../../domain/errors/errors.dart';
import '../../infra/datasources/search_datasource.dart';
import '../../infra/models/result_search_model.dart';

class HeroDatasource implements SearchDatasource {
  final Dio dio;
  HeroDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    var query = sanitize(searchText);
    var uri = 'https://www.superheroapi.com/api.php/10215271200251716/search/$query';

    final response = await dio.get(uri);

    if (response.statusCode == 200) {
      if (response.data['response'] == 'error') throw NotFound();

      final list = (response.data['results'] as List)
          .map((hero) =>
              ResultSearchModel(name: hero['name'], image: hero['image']['url'], id: int.parse(hero['id'])))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }

  String sanitize(String searchText) {
    // faz split com um ou mais espaços
    var listWords = searchText.toLowerCase().trim().split(new RegExp('\\s+'));

    var textQuery = listWords[0];

    if (listWords.length > 1) {
      for (var i = 1; i < listWords.length; i++) {
        textQuery = '$textQuery%20${listWords[i]}';
      }
    }

    return textQuery;
  }
}
