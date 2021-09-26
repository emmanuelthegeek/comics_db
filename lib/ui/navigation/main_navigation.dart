import 'package:comics_db_app/library/widgets/inherited/notifier_provider.dart';
import 'package:comics_db_app/widgets/auth/auth_model.dart';
import 'package:comics_db_app/widgets/auth/auth_widget.dart';
import 'package:comics_db_app/widgets/main_screen/main_screen_widget.dart';
import 'package:comics_db_app/widgets/main_screen/main_screen_model.dart';
import 'package:comics_db_app/widgets/movie_details/movie_details_model.dart';
import 'package:comics_db_app/widgets/movie_details/movie_details_widget.dart';
import 'package:comics_db_app/widgets/movie_list/movie_list_model.dart';
import 'package:comics_db_app/widgets/news/components/news_widget_popular.dart';
import 'package:comics_db_app/widgets/news/news_list_widget.dart';
import 'package:comics_db_app/widgets/trending/news_widget_trending.dart';
import 'package:comics_db_app/widgets/trending/trending_all_model.dart';
import 'package:comics_db_app/widgets/tv_details/tv_details_model.dart';
import 'package:comics_db_app/widgets/tv_details/tv_details_widget.dart';
import 'package:comics_db_app/widgets/tv_list/tv_list_model.dart';
import 'package:comics_db_app/widgets/tv_list/tv_list_widget.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const tv = '/tv';
  static const tvDetails = '/tv_details';
  static const news = '/news';
  static const trending = 'trending';
  static const popularMovie = '/popularMovie';
  static const networkConnectionError = '/errors/network_connection';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.auth;
  final routes = <String, Widget Function(BuildContext)>{
    'auth': (context) => NotifierProvider(create: () => AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(create: () => MainScreenModel(), child: const MainScreenWidget()),
    MainNavigationRouteNames.popularMovie: (context) => NotifierProvider(create: () => MovieListModel(), child: const NewsWidgetPopular()),
    MainNavigationRouteNames.tv: (context) => NotifierProvider(create: () => TVListModel(), child: const TVListWidget()),
    // '/': (context) => NotifierProvider(
    //     model: MainScreenModel(), child: const MainScreenWidget()),
    // '/trending': (context) => NotifierProvider(model: TrendingAllModel(), child: const NewsWidgetTrending()),
    // '/tv': (context) => NotifierProvider(
    //   model: TVListModel(), child: const TVListWidget())
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => NotifierProvider(
                create: () => MovieDetailsModel(movieId),
                child: const MovieDetailsWidget(),
            ),
        );
      case MainNavigationRouteNames.tvDetails:
        final arguments = settings.arguments;
        final tvId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (context) => NotifierProvider(
                create: () => TVDetailsModel(tvId),
                child: const TVDetailsWidget(),
            ),
        );
      default:
        const widget = Text('Ошибка навигации');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}