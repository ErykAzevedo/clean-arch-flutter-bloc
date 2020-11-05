import 'dart:convert';

import '../../domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  ResultSearchModel({name, image, id}) : super(name: name, image: image, id: id);

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(name: map['name'], image: map['image'], id: int.parse(map['id']));
  }

  factory ResultSearchModel.fromJson(String source) => ResultSearchModel.fromMap(json.decode(source));
}
