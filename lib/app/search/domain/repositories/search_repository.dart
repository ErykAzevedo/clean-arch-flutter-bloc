import 'package:dartz/dartz.dart';

import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
