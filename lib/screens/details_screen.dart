import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(delegate: SliverChildListDelegate(
            [
              _PosterAndTitle(movie: movie),
              _Overview(overview: movie.overview),
              const SizedBox(height: 20),
              CastingCards( movieId: movie.id )
            ]
          ))
        ],
      )
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
          color: Colors.black12,
          child: Text(movie.title,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          )
          ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final textTheme = Theme.of( context ).textTheme;

    return Container(
      margin: const EdgeInsets.only( top: 20 ),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular( 20 ),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2
                ),
                Text(movie.originalTitle,
                style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey,),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}',
                    style: textTheme.caption, overflow: TextOverflow.ellipsis, maxLines: 2
                    ),
                  ]
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of( context ).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(overview,
      textAlign: TextAlign.justify,
      style: Theme.of( context ).textTheme.subtitle1,
      )
    );
  }
}