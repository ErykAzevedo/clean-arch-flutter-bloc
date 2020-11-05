import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './app_widget.dart';
import './search/domain/usecases/search_by_text_impl.dart';
import './search/external/datasources/hero_datasource.dart';
import './search/infra/repositories/search_repository_impl.dart';
import './search/presenter/search_bloc.dart';
import './search/presenter/search_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => HeroDatasource(i())),
        Bind((i) => SearchBloc(i())),
      ];

  @override
  List<ModularRouter> get routers => [ModularRouter('/', child: (_, __) => SearchPage())];

  @override
  Widget get bootstrap => AppWidget();
}
