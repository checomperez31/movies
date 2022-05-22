import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/helpers/helpers.dart';
import 'package:movies/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _apiKey = '2c8fcb205693cb020a08265c0a28bcac';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  Map<int, List<Cast>> moviesCast = {};

  final debouncer = Debouncer(
    duration: const Duration( milliseconds: 500 )
  );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionsStreamController.stream;

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https( _baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    final response = await http.get( url );
    return response.body;
  }

  getOnDisplayMovies() async {
    final response = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson( response );
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    print('Cargando peliculas populares');
    _popularPage++;
    final response = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson( response );
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int id ) async {
    if ( moviesCast.containsKey(id) ) return moviesCast[id]!;

    print('Haciendo peticion de cast');

    final response = await _getJsonData('3/movie/${id}/credits');
    final creditsResponse = CreditsResponse.fromJson(response);

    moviesCast[id] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    var url = Uri.https( _baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': '$query',
    });
    final response = await http.get( url );
    final searchResponse = SearchResponse.fromJson( response.body );
    return searchResponse.results;
  }

  void getSuggestionsByQuery( String query ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await searchMovies(value);
      _suggestionsStreamController.add( results );
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });
    Future.delayed(const Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}