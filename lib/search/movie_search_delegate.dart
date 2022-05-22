import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if ( query.isEmpty ) {
      return const Center(
        child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130),
      );
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if ( !snapshot.hasData ) {
          return const Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130);
        }
        final movies = snapshot.data!;
        return ListView.builder(
          itemBuilder: (_, index) => _SuggestionItem(movies[index]),
          itemCount: movies.length,
        );
      }
    );
  }
}

class _SuggestionItem extends StatelessWidget {
  final Movie movie;
  const _SuggestionItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'sd-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}