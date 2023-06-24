import 'dart:convert';

import 'package:pokemon_explorer/config/api_config.dart';

PokemonResponse pokemonResponseFromJson(String str) =>
    PokemonResponse.fromJson(json.decode(str));

class PokemonResponse {
  PokemonResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  PokemonResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Pokemon.fromJson(v));
      });
    }
  }

  int? count;
  String? next;
  String? previous;
  List<Pokemon>? results;
}

Pokemon resultsFromJson(String str) => Pokemon.fromJson(json.decode(str));

class Pokemon {
  Pokemon({
    this.name,
    this.imageUrl,
  });

  Pokemon.fromJson(dynamic json) {
    name = json['name'];
    String url = json['url'];
    final segments = url.split('/');
    final id = segments[segments.length - 2];
    // String id = json['url'].toString().split('/').last;
    imageUrl = '${ApiConfig.imageBase}/$id.png';
  }

  String? name;
  String? imageUrl;
}
