import 'package:dartz/dartz.dart';

import '../../domain/entities/result_search.dart';
import '../../domain/errors/errors.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}
