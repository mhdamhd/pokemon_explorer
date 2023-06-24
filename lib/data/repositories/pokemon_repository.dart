import 'package:pokemon_explorer/config/api_config.dart';
import 'package:pokemon_explorer/data/data_providers/api_client.dart';
import 'package:pokemon_explorer/data/models/pokemon_response.dart';
import 'package:pokemon_explorer/data/utils/error_handler.dart';

class PokemonRepository {
  final ApiClient apiClient;

  PokemonRepository(this.apiClient);

  Future<PokemonResponse> getPokemons(
      {int? offset = 0, int? limit = 10}) async {
    PokemonResponse? pokemonResponse;
    try {
      pokemonResponse = await apiClient.invokeApi<PokemonResponse>(
        '${ApiConfig.getPokemons}?offset=$offset&limit=$limit',
      );
    } catch (e, s) {
      throw ErrorHandler(exception: e, stackTrace: s).rethrowError();
    }
    return pokemonResponse!;
  }
}
