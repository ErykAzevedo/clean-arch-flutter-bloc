import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import './states/state.dart';
import '../edge/usecases/search_by_text.dart';

class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;
  SearchBloc(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    yield SearchLoading();
    final result = await usecase(searchText);
    yield result.fold((l) => SearchError(error: l), (r) => SearchSuccess(list: r));
  }

  @override
  Stream<Transition<String, SearchState>> transformEvents(Stream<String> events, transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 800)), transitionFn);
  }
}
