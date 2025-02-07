import 'package:clean_arch_flutter/app/search/domain/entities/result_search.dart';
import 'package:clean_arch_flutter/app/search/domain/errors/errors.dart';
import 'package:clean_arch_flutter/app/search/domain/repositories/search_repository.dart';
import 'package:clean_arch_flutter/app/search/domain/usecases/search_by_text_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('Deve retornar um InvalidTextError caso o texto seja errado', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    var result = await usecase(null);
    //expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());

    result = await usecase('');
    expect(result.fold((l) => l, (r) => r), isA<InvalidTextError>());
  });

  test('Deve retornar uma lista de ResultSearch', () async {
    when(repository.search(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase('Eryk');
    expect(result | null, isA<List<ResultSearch>>());
  });
}
