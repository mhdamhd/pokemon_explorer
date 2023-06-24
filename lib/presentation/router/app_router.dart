import 'package:pokemon_explorer/data/data_providers/api_client.dart';
import 'package:pokemon_explorer/data/repositories/app_config_repository.dart';
import 'package:pokemon_explorer/data/repositories/pokemon_repository.dart';
import 'package:pokemon_explorer/logic/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_explorer/presentation/screens/animations/animations_screen.dart';
import 'package:pokemon_explorer/presentation/screens/home/home_screen.dart';
import 'package:pokemon_explorer/presentation/screens/pokemon/pokemon_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_explorer/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  late final ApiClient apiClient;
  late final AppConfigRepository appConfigRepository;

  AppRouter({required this.apiClient, required this.appConfigRepository});

  Route generateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? '/';

    final routeArguments = settings.arguments;

    switch (routeName) {
      case '/':
        return _buildInitialRoute();
      case SplashScreen.routeName:
        return _buildSplashRoute();
      case HomeScreen.routeName:
        return _buildHomeRoute();
      case AnimationsScreen.routeName:
        return _buildAnimationsRoute(routeArguments as String);
      case PokemonScreen.routeName:
        return _buildPokemonRoute();
      default:
        return _buildInitialRoute();
    }
  }

  Route _buildInitialRoute() => _buildSplashRoute();

  Route _buildSplashRoute() =>
      MaterialPageRoute(builder: (_) => const SplashScreen());

  Route _buildHomeRoute() =>
      MaterialPageRoute(builder: (_) => const HomeScreen());

  Route _buildAnimationsRoute(String name) =>
      MaterialPageRoute(builder: (_) => AnimationsScreen(name: name));

  Route _buildPokemonRoute() => MaterialPageRoute(
      builder: (_) => BlocProvider(
          create: (_) => PokemonBloc(PokemonRepository(apiClient)),
          child: const PokemonScreen()));
}
