import 'package:comics_db_app/app_colors.dart';
import 'package:comics_db_app/domain/api_client/api_client.dart';
import 'package:comics_db_app/domain/entity/movie.dart';
import 'package:comics_db_app/resources/resources.dart';
import 'package:comics_db_app/ui/widgets/movie_list/movie_list_model.dart';
import 'package:comics_db_app/ui/widgets/movie_top_rated/top_rated_movie_model.dart';
import 'package:comics_db_app/ui/widgets/upcoming_movie/upcoming_movie_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({Key? key}) : super(key: key);

  @override
  //TODO не совсем понимаю зачем тут модель одна передается, если используется минимум 3
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => MovieListModel(), child: const MovieListWidget());
}


class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  Widget build(BuildContext context) {
    final topRatedMovieModel = context.watch<TopRatedMovieModel>();
    // if (topRatedMovieModel == null) return const SizedBox.shrink();
    return Scaffold (
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal:   8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(AppImages.movieAppBarLogo)
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TODO оптимизировать значки
                  GestureDetector(
                    onTap: () {},
                      child: const Icon(Icons.search, color: AppColors.searchIcon, size: 30,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                        child: const Icon(Icons.filter_alt_outlined, color: AppColors.ratingThumb, size: 30,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                      child: const Icon(Icons.menu, color: AppColors.ratingThumb, size: 30,),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.kPrimaryColorNew,
      ),
      body: ColoredBox(
        color: AppColors.kPrimaryColorNew,
        child: ListView(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: SizedBox(
                    height: 220,
                    child: _TopRatedMovieWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Популярные', style: TextStyle(color: AppColors.genresText, fontSize: 21, fontWeight: FontWeight.w600)),
                      Text('Все', style: TextStyle(color: AppColors.ratingText, fontSize: 15),),
                    ],
                  ),
                ),
         const SizedBox(
           height: 200,
             child: _PopularMovieWidget(),
                     ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Скоро', style: TextStyle(color: AppColors.genresText, fontSize: 21, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
          const SizedBox(
                  height: 160,
                  width: 335,
                  child: _ComingSoonMovieWidget(),
                ),
                  ],
                ),
              ],
            ),
                  ),
      );
      //     // TODO FIX doesn't work
      //      ListView.builder(
      //           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      //           padding: const EdgeInsets.only(top: 70.0),
      //           itemCount: model.movies.length,
      //           itemExtent: 165,
      //           itemBuilder: (BuildContext context, int index) {
      //             model.showedMovieAtIndex(index);
      //             final movie = model.movies[index];
      //             final posterPath = movie.posterPath;
      //             return Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 16.0, vertical: 10.0),
      //               child: Stack(
      //                 children: [
      //                   Container(
      //                     decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         border:
      //                         Border.all(color: Colors.black.withOpacity(0.2)),
      //                         borderRadius:
      //                         const BorderRadius.all(Radius.circular(20.0)),
      //                         boxShadow: [
      //                           BoxShadow(
      //                             color: Colors.black.withOpacity(0.1),
      //                             blurRadius: 8,
      //                             offset: const Offset(0, 2),
      //                           )
      //                         ]),
      //                     clipBehavior: Clip.hardEdge,
      //                     child: Row(
      //                       children: [
      //                         posterPath != null ? Image.network(
      //                             ApiClient.imageUrl(posterPath), width: 95)
      //                             : const SizedBox.shrink(),
      //                         const SizedBox(width: 15.0),
      //                         MovieCard(movie: movie, model: model),
      //                         const SizedBox(width: 10.0),
      //                       ],
      //                     ),
      //                   ),
      //                   Material(
      //                     color: Colors.transparent,
      //                     child: InkWell(
      //                       borderRadius: BorderRadius.circular(20.0),
      //                       onTap: () => model.onMovieTap(context, index),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             );
      //           }),
      //     ),
  }
}

class _ComingSoonMovieWidget extends StatelessWidget {
  const _ComingSoonMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final upcomingMovieModel = Provider.of<UpcomingMovieModel>(context, listen: true);
    // if (popularMovieModel == null) return const SizedBox.shrink();
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: upcomingMovieModel.movies.length,
        itemExtent: 110,
        itemBuilder: (BuildContext context, int index) {
          upcomingMovieModel.showedMovieAtIndex(index);
          final upcomingMovie = upcomingMovieModel.movies[index];
          final posterPath = upcomingMovie.posterPath;
          return InkWell(
            onTap: () => upcomingMovieModel.onMovieTap(context, index),
            child: _ComingSoonListItemWidget(
              index: index,
              posterPath: posterPath,
              movie: upcomingMovie,
              upcomingMovieModel: upcomingMovieModel,
            ),
          );
        }
    );
  }
}

class _ComingSoonListItemWidget extends StatelessWidget {
  const _ComingSoonListItemWidget({
    Key? key,
    required this.index,
    required this.posterPath,
    required this.movie,
    required this.upcomingMovieModel,
  }) : super(key: key);

  final int index;
  final String? posterPath;
  final Movie movie;
  final UpcomingMovieModel? upcomingMovieModel;

  @override
  Widget build(BuildContext context) {
    final upcomingMovieModel = Provider.of<UpcomingMovieModel>(context, listen: true);
    // if (popularMovieModel == null) return const SizedBox.shrink();
    final upcomingMovie = upcomingMovieModel.movies[index];
    final posterPath = upcomingMovie.posterPath;
    return Container(
      height: 160,
      width: 335,
      // borderRadius: const BorderRadius.all(Radius.circular(28)),
      // clipBehavior: Clip.hardEdge,
      child: posterPath != null ?
      Image.network(ApiClient.imageUrl(posterPath)) : const SizedBox.shrink(),
    );
  }
}




class _PopularMovieWidget extends StatelessWidget {
  const _PopularMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final popularMovieModel = context.watch<MovieListModel>();
    final popularMovieModel = Provider.of<MovieListModel>(context, listen: true);
    // if (popularMovieModel == null) return const SizedBox.shrink();
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularMovieModel.movies.length,
        itemExtent: 110,
        itemBuilder: (BuildContext context, int index) {
          popularMovieModel.showedPopularMovieAtIndex(index);
          final popularMovie = popularMovieModel.movies[index];
          final posterPath = popularMovie.posterPath;
          return InkWell(
            onTap: () => popularMovieModel.onMovieTap(context, index),
            child: _PopularMovieListItemWidget(
                index: index,
                posterPath: posterPath,
                movie: popularMovie,
                popularMovieModel: popularMovieModel,
            ),
          );
        }
    );
  }
}

class _PopularMovieListItemWidget extends StatelessWidget {
  const _PopularMovieListItemWidget({
    Key? key,
    required this.index,
    required this.posterPath,
    required this.movie,
    required this.popularMovieModel,
  }) : super(key: key);

  final int index;
  final String? posterPath;
  final Movie movie;
  final MovieListModel? popularMovieModel;

  @override
  Widget build(BuildContext context) {
    final popularMovieModel = Provider.of<MovieListModel>(context, listen: true);
    // if (popularMovieModel == null) return const SizedBox.shrink();
    final popularMovie = popularMovieModel.movies[index];
    final posterPath = popularMovie.posterPath;
    return SizedBox(
      child: Container(
        height: 150,
        width: 100,
        // borderRadius: const BorderRadius.all(Radius.circular(28)),
        // clipBehavior: Clip.hardEdge,
        child: posterPath != null ?
            Image.network(ApiClient.imageUrl(posterPath)) : const SizedBox.shrink(),
        ),
    );
  }
}

class _TopRatedMovieWidget extends StatelessWidget {
  const _TopRatedMovieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topRatedMovieModel = Provider.of<TopRatedMovieModel>(context, listen: true);
    // if (topRatedMovieModel == null) return const SizedBox.shrink();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: topRatedMovieModel.movies.length,
        // itemExtent: 300,
        itemBuilder: (BuildContext context, int index) {
          topRatedMovieModel.showedMovieAtIndex(index);
          final topMovie = topRatedMovieModel.movies[index];
          final posterPath = topMovie.posterPath;
          final backdropPath = topMovie.backdropPath;
          return InkWell(
            onTap: () => topRatedMovieModel.onMovieTap(context, index),
            child: _TopRatedMovieListItemWidget(
                index: index,
                backdropPath: backdropPath,
                movie: topMovie,
                topMovieModel: topRatedMovieModel),
          );
        }
    );
  }
}

class _TopRatedMovieListItemWidget extends StatelessWidget {
  const _TopRatedMovieListItemWidget({
    Key? key,
    required this.index,
    required this.backdropPath,
    required this.movie,
    required this.topMovieModel,
  }) : super(key: key);
  
  final int index;
  final String? backdropPath;
  final Movie movie;
  final TopRatedMovieModel? topMovieModel;

  @override
  Widget build(BuildContext context) {
    final topRatedMovieModel = Provider.of<TopRatedMovieModel>(context, listen: true);
    final topMovie = topRatedMovieModel.movies[index];
    final posterPath = topMovie.posterPath;
    final backdropPath = topMovie.backdropPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      // child: DecoratedBox(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     border: Border.all(color: Colors.black.withOpacity(0.2)),
      //     borderRadius: const BorderRadius.all(Radius.circular(28)),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.purple.withOpacity(0.1),
      //         blurRadius: 8,
      //         offset: const Offset(0,2),
      //       ),
      //     ],
      //   ),
        child: posterPath != null ? Image.network(ApiClient.imageUrl(backdropPath!)) : const SizedBox.shrink(),
    );
        // ),
      // ),
    // );
  }
}