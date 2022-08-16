import 'dart:async';

import 'package:bloc/bloc.dart';

// import 'package:com_app/domain/api_client/api_client_exception.dart';
import 'package:comics_db_app/domain/api_client/api_client_exception.dart';
import 'package:comics_db_app/domain/entity/movie_details.dart';
import 'package:comics_db_app/domain/services/movie_service.dart';
import 'package:comics_db_app/ui/navigation/main_navigation.dart';
import 'package:comics_db_app/ui/widgets/localized_model_storage.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/movie_details_data.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/poster_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsCubitState> {
  late DateFormat _dateFormat;
  final data = MovieDetailsData();
  final posterData = MovieDetailsPosterData(
    title: '',
    tagline: '',
    voteCount: 0,
    popularity: 0,
    voteAverage: 0,
    // backdropPath: '',
    // posterPath: '',
  );

  String _locale = '';
  final _movieService = MovieService();
  final int movieId;
  final _localeStorage = LocalizedModelStorage();
  MovieDetails? _movieDetails;

  MovieDetails? get movieDetails => _movieDetails;

  MovieDetailsCubit(this.movieId)
      // TODO should fix
      : super(const MovieDetailsCubitState(
          overview: '',
          localeTag: '',
          // posterPath: '',
          title: '',
          tagline: '',
          voteAverage: 0,
          voteCount: 0,
          popularity: 0,
          // backdropPath: '',
        )) {
    emit(MovieDetailsCubitState(
      overview: state.overview,
      localeTag: state.localeTag,
      // posterPath: state.posterPath,
      title: state.title,
      tagline: state.tagline,
      voteAverage: state.voteAverage,
      voteCount: state.voteCount,
      popularity: state.popularity,
      // backdropPath: state.backdropPath,
    ));
  }

  Future<void> loadMovieDetails(BuildContext context) async {
    // try {
    final details = await _movieService.loadMovieDetails(movieId: movieId, locale: state.localeTag);
    // TODO: add isFavorite to update
    updateData(details.details);
    // }
    // on ApiClientException catch (e) {
    //   _handleApiClientException(e, context);
    // }
  }

  void _handleApiClientException(ApiClientException exception, BuildContext context) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        // _authService.logout();
        MainNavigation.resetNavigation(context);
        break;
      case ApiClientExceptionType.other:
        print('exception other');
        break;
      default:
        print(exception);
    }
  }

  Future<void> setupMovieDetailsLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMd(locale);
    // if (state.localeTag == localeTag) return;
    // if (!_localeStorage.updateLocale(locale)) return;
    // final newState = state.copyWith(localeTag: localeTag);
    // emit(newState);
    // _dateFormat = DateFormat.yMMMd(localeTag);
    updateData(null);
    await loadMovieDetails(context);
  }

  // void onMovieTap(BuildContext context, int index) {
  //   var movies = <MovieListData>[];
  //   final id = movies[index].id;
  // final id = mov[index].id;
  // Navigator.of(context).pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  // }

  void updateData(MovieDetails? details /* bool isFavorite*/) {
    // final releaseDate = details?.releaseDate;
    // final releaseDateTitle = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    data.overview = details?.overview ?? 'Loading description...';
    // TODO: title twice in posterData
    data.title = details?.title ?? 'Loading title..';
    data.tagline = details?.tagline ?? 'Loading tagline..';
    data.voteAverage = details?.voteAverage ?? 0;
    posterData.voteCount = details?.voteCount ?? 0;
    posterData.popularity = details?.popularity ?? 0;
    // posterData.backdropPath = details?.backdropPath ?? '';
    // posterData.posterPath = details?.posterPath.toString();
    // data.posterData.posterPath = details?.posterPath ?? '';
    // data.posterPath = details?.posterPath ?? '';
    // data.posterData = MovieDetailsPosterData(
    //   title: details?.title ?? '',
    //   voteCount: details?.voteCount ?? 0,
    //   popularity: details?.popularity ?? 0,
    //   posterPath: details?.posterPath ?? '',
    // );
    var title = data.title;
    var tagline = data.tagline;
    var overview = data.overview;
    var voteAverage = data.voteAverage;
    var voteCount = posterData.voteCount;
    var popularity = posterData.popularity;
    // var posterPath = posterData.posterPath;
    // var backdropPath = posterData.backdropPath;
    final newState = state.copyWith(
      overview: overview,
      title: title,
      tagline: tagline,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      // backdropPath: backdropPath,
      // posterPath: posterPath,
    );
    emit(newState);
  }
}
