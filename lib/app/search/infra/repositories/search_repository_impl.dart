import 'package:dartz/dartz.dart';

import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/search_repository.dart';
import '../../infra/datasources/search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on NotFound catch (e) {
      return Left(NotFound());
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
