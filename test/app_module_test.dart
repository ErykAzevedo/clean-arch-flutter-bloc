import 'dart:convert';

import 'package:clean_arch_flutter/app/app_module.dart';
import 'package:clean_arch_flutter/app/search/domain/entities/result_search.dart';
import 'package:clean_arch_flutter/app/search/domain/usecases/search_by_text_impl.dart';
import 'package:clean_arch_flutter/app/search/edge/usecases/search_by_text.dart';
import 'package:clean_arch_flutter/app/search/utils/hero_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test('Deve recuperar o usecase em erro', () {
    final usecase = Modular.get<SearchByText>();

    expect(usecase, isA<SearchByTextImpl>());
  });

  test('Deve Trazer uma lista de ResultSearch', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(data: jsonDecode(heroResponse), statusCode: 200));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase("rio");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
