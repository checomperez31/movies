import 'package:flutter/material.dart';
import 'package:movies/providers/providers.dart';
import 'package:provider/provider.dart';

import 'package:movies/screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {

  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => MoviesProvider(), lazy: false)
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'details': (_) => const DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.amber,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
          elevation: 0
        )
      ),
    );
  }
}