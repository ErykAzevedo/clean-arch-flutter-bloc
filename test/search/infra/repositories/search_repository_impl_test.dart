import 'package:clean_arch_flutter/app/search/domain/entities/result_search.dart';
import 'package:clean_arch_flutter/app/search/domain/errors/errors.dart';
import 'package:clean_arch_flutter/app/search/infra/datasources/search_datasource.dart';
import 'package:clean_arch_flutter/app/search/infra/models/result_search_model.dart';
import 'package:clean_arch_flutter/app/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test('Deve retornar uma lista de ResultSearchModel', () async {
    when(datasource.getSearch(any)).thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search("eryk");

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('Deve retornar um DatasourceError se falhar', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());

    final result = await repository.search("eryk");

    expect(result.fold((l) => l, (r) => r), isA<DatasourceError>());
  });
}
