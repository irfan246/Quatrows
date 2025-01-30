import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quatrows/application/challenge_bloc/quatrows_bloc.dart';
import 'package:quatrows/application/easy_bloc/quatrows_bloc.dart';
import 'package:quatrows/presentation/page/game_screen.dart';
import 'package:quatrows/presentation/page/game_screen_challenge.dart';
import 'package:quatrows/presentation/page/home_screen.dart';
import 'package:quatrows/presentation/page/main_screen.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/main':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/game':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => QuatrowsBloc()..add(StartGameEvent()),
                  child: GameScreen(),
                ));
      case '/game_challenge':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) =>
                      QuatrowsChallengeBloc()..add(StartGameEventChallenge()),
                  child: GameScreenChallenge(),
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Page not found!")),
      ),
    );
  }
}
