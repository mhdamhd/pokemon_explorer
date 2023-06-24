import 'package:pokemon_explorer/data/models/pokemon_response.dart';
import 'package:pokemon_explorer/res/app_res.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      height: 500.h,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45.r),
          //set border radius more than 50% of height and width to make circle
        ),
        elevation: 5.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: pokemon.imageUrl ?? '',
              fit: BoxFit.cover,
              height: 500.h,
              width: 400.w,
              placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
              const Icon(Icons.error),
            ),
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
            child: Text(pokemon.name ?? '', style: Styles.label1.copyWith(color: Colors.black), overflow: TextOverflow.clip),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
