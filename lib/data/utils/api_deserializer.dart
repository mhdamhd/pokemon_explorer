import 'dart:developer';

import 'package:pokemon_explorer/data/models/pokemon_response.dart';
import 'package:pokemon_explorer/data/utils/errors.dart';

import 'package:flutter/services.dart';

class ApiDeserializer<R> {
  final String rawJson;

  ApiDeserializer({required this.rawJson});

  dynamic deserialize() {
    try {
      switch (R) {
        case String:
          return rawJson;
        case PokemonResponse:
          return pokemonResponseFromJson(rawJson);
        default:
          throw PlatformException(code: '', message: 'can not found response');
      }
    } on Error catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw ParsingException(
        message: e.toString(),
        stack: s.toString(),
      );
    }
  }
}
