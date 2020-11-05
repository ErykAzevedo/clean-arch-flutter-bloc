import 'dart:convert';

import 'package:clean_arch_flutter/app/search/domain/errors/errors.dart';
import 'package:clean_arch_flutter/app/search/external/datasources/hero_datasource.dart';
import 'package:clean_arch_flutter/app/search/utils/hero_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = HeroDatasource(dio);

  test("Deve retornar uma lista de ResultSearchModel", () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(heroResponse), statusCode: 200));
    final future = datasource.getSearch(" Marcos   Antunes ");
    expect(future, completes);
  });

  test("Deve retornar um DatasourceError caso não seja 200", () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: null, statusCode: 401));
    final future = datasource.getSearch(" Marcos   Antunes ");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Deve retornar um DatasourceError caso não seja 200", () async {
    when(dio.get(any)).thenThrow(Exception());
    final future = datasource.getSearch(" Marcos   Antunes ");
    expect(future, throwsA(isA<Exception>()));
  });

  test('Retorna string tratada para a query', () {
    var text = ' O   rato roeu     a roupa  do rei de Roma ';
    final searchText = datasource.sanitize(text);
    expect(searchText, 'o%20rato%20roeu%20a%20roupa%20do%20rei%20de%20roma');
  });
}
