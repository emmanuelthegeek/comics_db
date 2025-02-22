// Flutter imports:
import 'dart:ui';

import 'package:comics_db_app/domain/blocs/movie/favorite_movies_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/movie/movie_popular_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/movie/now_playing_movie_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/movie/top_rated_movie_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/movie/upcoming_movie_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/people/popular_people_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/theme/theme_bloc.dart';
import 'package:comics_db_app/domain/blocs/tv/tv_airing_today_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/tv/tv_list_state.dart';
import 'package:comics_db_app/domain/blocs/tv/tv_on_the_air_bloc.dart';
import 'package:comics_db_app/domain/blocs/tv/tv_popular_list_bloc.dart';
import 'package:comics_db_app/domain/blocs/tv/tv_top_rated_list_bloc.dart';
import 'package:comics_db_app/ui/widgets/account/account_details_cubit.dart';
import 'package:comics_db_app/ui/widgets/favorite_screen/favorite_movie_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/movie_list/movie_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/movie_now_playing_list/now_playing_movie_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/movie_top_rated/top_rated_movie_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/people_widget/popular_people_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/tv_airing_today/tv_airing_today_cubit.dart';
import 'package:comics_db_app/ui/widgets/tv_list/tv_popular_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/tv_on_the_air/tv_on_the_air_cubit.dart';
import 'package:comics_db_app/ui/widgets/tv_top_rated/tv_top_rated_list_cubit.dart';
import 'package:comics_db_app/ui/widgets/upcoming_movie_list/upcoming_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';

// Project imports:
import 'package:comics_db_app/ui/navigation/main_navigation.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // TODO: нужно отказаться от mainNavigation
  static final mainNavigation = MainNavigation();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (_) => AccountDetailsCubit(),
        ),
        BlocProvider(
          create: (_) =>
              TopRatedMovieListCubit(
                topRatedMovieListBloc: TopRatedMovieListBloc(
                  const MovieListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              MoviePopularListCubit(
                movieListBloc: MoviePopularListBloc(
                  const MovieListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              UpcomingMovieListCubit(
                upcomingMovieListBloc: UpcomingMovieListBloc(
                  const MovieListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              NowPlayingMovieListCubit(
                nowPlayingMovieListBloc: NowPlayingMovieListBloc(
                  const MovieListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              TvPopularListCubit(
                tvPopularListBloc: TvPopularListBloc(
                  TvListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              TvAiringTodayListCubit(
                tvAiringTodayListBloc: TvAiringTodayListBloc(
                  TvListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              TvTopRatedListCubit(
                tvTopRatedListBloc: TvTopRatedListBloc(
                  TvListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              TvOnTheAirListCubit(
                tvOnTheAirListBloc: TvOnTheAirListBloc(
                  TvListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              PeopleListCubit(
                peopleListBloc: PeopleListBloc(
                  const PeopleListState.initial(),
                ),
              ),
        ),
        BlocProvider(
          create: (_) =>
              FavoriteMovieListCubit(
                  favoriteMovieListBloc: FavoriteMovieListBloc(
                    const MovieListState.initial(),
                  ),
              ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),
            // builder: (context, child) {
            //   return ScrollConfiguration(
            //     behavior: CustomBehavior(),
            //     child: child!,
            //   );
            // },
            theme: state.theme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
              Locale('en', ''),
            ],
            routes: mainNavigation.routes,
            initialRoute: MainNavigationRouteNames.loaderWidget,
            onGenerateRoute: mainNavigation.onGenerateRoute,
          );
        },
      ),
    );
  }
}
