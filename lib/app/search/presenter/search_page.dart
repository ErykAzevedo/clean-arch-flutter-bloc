import 'package:clean_arch_flutter/app/search/domain/entities/result_search.dart';
import 'package:clean_arch_flutter/app/search/domain/errors/errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './search_bloc.dart';
import './states/state.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SuperHero"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: bloc.add,
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Search.."),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: bloc,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return Center(
                    child: Text('Digite um nome de super-herói em inglês'),
                  );
                }
                if (state is SearchError) {
                  if (state.error is InvalidTextError) {
                    return Center(
                      child: Text('Digite um nome de super-herói em inglês'),
                    );
                  }
                  if (state.error is NotFound) {
                    return Center(
                      child: Text('Personagem não encontrado'),
                    );
                  }
                  return Center(
                    child: Text('Houve um Erro na API'),
                  );
                }
                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final list = (state as SearchSuccess).list;
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: buildGridView(list),
                );
              }),
        )
      ]),
    );
  }

  GridView buildGridView(List<ResultSearch> list) {
    return GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 1.0, mainAxisSpacing: 1.0),
        itemBuilder: (_, id) {
          final hero = list[id];
          return Stack(children: [
            Center(
              child: Card(
                elevation: 8,
                child: Image.network(
                  hero.image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Center(
                child: SizedBox(
                  height: 30,
                  child: Text(
                    hero.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ])
          ]);
        });
  }
}
