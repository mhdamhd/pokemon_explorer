part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class GetPokemons extends PokemonEvent {
  final int? offset;
  final int? limit;
  final bool loading;

  const GetPokemons({this.offset, this.limit, this.loading = true});

  @override
  List<Object?> get props => [offset, limit, loading];
}
