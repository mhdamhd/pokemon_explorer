import 'package:pokemon_explorer/data/data_providers/api_client.dart';
import 'package:pokemon_explorer/data/utils/error_handler.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<void> signout() async {
    try {
      await apiClient.removeToken();
    } catch (e, s) {
      throw ErrorHandler(exception: e, stackTrace: s).rethrowError();
    }
  }
}
