import 'dart:async';

import 'package:pokemon_explorer/data/repositories/pokemon_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_explorer/data/models/pokemon_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  PokemonBloc(this.pokemonRepository) : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    try {
      if (event is GetPokemons) {
        if (event.loading) {
          yield PokemonLoading();
        }
        final pokemonResponse = await pokemonRepository.getPokemons(
            offset: event.offset, limit: event.limit);
        yield PokemonLoaded(pokemonResponse);
      }
    } catch (e) {
      yield PokemonError(e);
    }
  }
}
