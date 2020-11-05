import 'package:clean_arch_flutter/app/search/domain/entities/result_search.dart';
import 'package:clean_arch_flutter/app/search/domain/errors/errors.dart';
import 'package:clean_arch_flutter/app/search/edge/usecases/search_by_text.dart';
import 'package:clean_arch_flutter/app/search/presenter/search_bloc.dart';
import 'package:clean_arch_flutter/app/search/presenter/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("Deve retornar error", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));
    expect(bloc, emitsInOrder([isA<SearchLoading>(), isA<SearchError>()]));
    bloc.add("marcos");
  });
  test("Devem retornar os estds na ordem correta", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));
    expect(bloc, emitsInOrder([isA<SearchLoading>(), isA<SearchSuccess>()]));
    bloc.add("marcos");
  });
}
