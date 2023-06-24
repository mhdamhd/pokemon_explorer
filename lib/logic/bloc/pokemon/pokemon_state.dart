part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitial extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final PokemonResponse pokemonResponse;

  const PokemonLoaded(this.pokemonResponse);

  @override
  List<Object> get props => [pokemonResponse];
}

class PokemonLoading extends PokemonState {}

class PokemonError extends PokemonState {
  final Object exception;

  const PokemonError(this.exception);
}
