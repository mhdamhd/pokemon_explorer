import 'package:pokemon_explorer/data/models/pokemon_response.dart';
import 'package:pokemon_explorer/data/utils/error_handler.dart';
import 'package:pokemon_explorer/logic/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_explorer/presentation/widgets/common/common.dart';
import 'package:pokemon_explorer/presentation/widgets/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class PokemonScreen extends StatefulWidget {
  static const String routeName = '/pokemon';

  const PokemonScreen({Key? key}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  late final PokemonBloc _bloc;
  int offset = 0;
  int limit = 10;
  List<Pokemon> pokemons = [];
  bool enablePullUp = true;
  late final RefreshController refreshController;

  @override
  void initState() {
    refreshController = RefreshController();
    _bloc = context.read<PokemonBloc>();
    _getPokemons();
    super.initState();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  _getPokemons({bool loading = true}) {
    _bloc.add(GetPokemons(offset: offset, limit: limit, loading: loading));
  }

  _refresh() {
    setState(() {
      enablePullUp = true;
      pokemons = [];
      offset = 0;
      _getPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pokemons',
        ),
        titleSpacing: 0,
      ),
      body: BlocConsumer<PokemonBloc, PokemonState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is PokemonLoaded) {
            setState(() {
              pokemons.addAll(state.pokemonResponse.results ?? []);
              offset += limit;
              refreshController.loadComplete();
              refreshController.refreshCompleted();
              enablePullUp = state.pokemonResponse.next != null;
            });
          }
        },
        builder: (ctx, state) {
          if (state is PokemonLoading) {
            return _buildLoader();
          } else if (state is PokemonError) {
            return ErrorHandler(exception: state.exception).buildErrorWidget(
                context: context, retyCallback: _getPokemons);
          } else if (state is PokemonLoaded) {
            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: enablePullUp,
              physics: const ClampingScrollPhysics(),
              onRefresh: _refresh,
              onLoading: () {
                _getPokemons(loading: false);
              },
              child: pokemons.isEmpty
                  ? const EmptyCard()
                  : ListView(
                      children: [SizedBox(height: 50.h,),...pokemons
                          .map((e) => PokemonCard(
                                pokemon: e,
                              ))
                          .toList()],
                    ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildLoader() {
    Widget shimmerElement = Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(45.r)),
          height: 500.h,
        ));
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(6, (index) => index == 0 ? SizedBox(height: 50.h) : shimmerElement),
    );
  }
}
