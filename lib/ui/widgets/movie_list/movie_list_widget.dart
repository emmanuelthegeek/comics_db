import 'package:comics_db_app/app_colors.dart';
import 'package:comics_db_app/domain/api_client/image_downloader.dart';
import 'package:comics_db_app/resources/resources.dart';
import 'package:comics_db_app/ui/navigation/main_navigation.dart';
import 'package:comics_db_app/ui/widgets/movie_list/movie_list_model.dart';
import 'package:comics_db_app/ui/widgets/movie_top_rated/top_rated_movie_model.dart';
import 'package:comics_db_app/ui/widgets/upcoming_movie/upcoming_movie_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({Key? key}) : super(key: key);

  @override
  //TODO не совсем понимаю зачем тут модель одна передается
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => MovieListViewModel(),
        child: const MovieListWidget(),
      );
}

// TODO: maybe change to stateless
class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListViewModel>().setupPopularMovieLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: перенести в каждую категорию
    AlertDialog dialog = const AlertDialog(
      // TODO: after refactoring search doesn't work
      content: _SearchWidget(),
    );
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [Image.asset(AppImages.movieAppBarLogo)],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // TODO оптимизировать значки
                  _SearchIconWidget(dialog: dialog),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.ratingThumb,
                        size: 30,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.menu,
                      color: AppColors.ratingThumb,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: ColoredBox(
        color: AppColors.kPrimaryColor,
        child: ListView(
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
                  child: SizedBox(
                    height: 180,
                    child: _TopRatedMovieWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular',
                        style: TextStyle(
                          color: AppColors.genresText,
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pushNamed(MainNavigationRouteNames.popularMovie),
                        child: const Text(
                          'See All',
                          style: TextStyle(color: AppColors.ratingText, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: _PopularMovieWidget(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Coming Soon',
                        style: TextStyle(color: AppColors.genresText, fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: _UpcomingMovieWidget(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchIconWidget extends StatelessWidget {
  const _SearchIconWidget({
    Key? key,
    required this.dialog,
  }) : super(key: key);

  final AlertDialog dialog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<void>(context: context, builder: (context) => dialog);
      },
      child: const Icon(
        Icons.search,
        color: AppColors.searchIcon,
        size: 30,
      ),
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: поменять на модель поиска по всем фильмам
    final model = context.read<MovieListViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchPopularMovie,
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: const TextStyle(
            color: AppColors.kPrimaryColor,
          ),
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kPrimaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kPrimaryColor),
          ),
        ),
      ),
    );
  }
}

class _UpcomingMovieWidget extends StatefulWidget {
  const _UpcomingMovieWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_UpcomingMovieWidget> createState() => _UpcomingMovieWidgetState();
}

class _UpcomingMovieWidgetState extends State<_UpcomingMovieWidget> {
  int _currentMovie = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UpcomingMovieModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final upcomingMovieModel = context.watch<UpcomingMovieModel>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
          child: Stack(
            children: [
              Container(
                height: 200,
                width: 350,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  // color: AppColors.movieBorderLine,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        _currentMovie = value;
                      });
                    },
                    // TODO: уменьшить кол-во фильмов либо исправить ползунок
                    itemCount: upcomingMovieModel.movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      upcomingMovieModel.showedMovieAtIndex(index);
                      final upcomingMovie = upcomingMovieModel.movies[index];
                      final backdropPath = upcomingMovie.backdropPath;
                      return InkWell(
                        onTap: () => upcomingMovieModel.onMovieTap(context, index),
                        child: backdropPath != null
                            ? Image.network(ImageDownloader.imageUrl(backdropPath))
                            : const SizedBox.shrink(),
                      );
                    }),
              ),
              // TODO: сделать в отдельный виджет
              Positioned(
                left: 50,
                top: 40,
                right: 50,
                bottom: 10,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(upcomingMovieModel.movies.length, (index) => buildDotNew(index: index)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildDotNew({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 5.0),
      height: 6,
      width: _currentMovie == index ? 20 : 6,
      decoration: BoxDecoration(
        color: _currentMovie == index ? Colors.white : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class _PopularMovieWidget extends StatefulWidget {
  const _PopularMovieWidget({Key? key}) : super(key: key);

  @override
  State<_PopularMovieWidget> createState() => _PopularMovieWidgetState();
}

class _PopularMovieWidgetState extends State<_PopularMovieWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListViewModel>().setupPopularMovieLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    final popularMovieModel = context.watch<MovieListViewModel>();
    return PopularMovieListWidget(popularMovieModel: popularMovieModel);
  }
}

class PopularMovieListWidget extends StatelessWidget {
  const PopularMovieListWidget({
    Key? key,
    required this.popularMovieModel,
  }) : super(key: key);

  final MovieListViewModel popularMovieModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: popularMovieModel.movies.length,
      itemBuilder: (BuildContext context, int index) {
        popularMovieModel.showedPopularMovieAtIndex(index);
        final popularMovie = popularMovieModel.movies[index];
        final posterPath = popularMovie.posterPath;
        // TODO: вынести в отдельный виджет?
        return InkWell(
          onTap: () => popularMovieModel.onMovieTap(context, index),
          child: _PopularMovieListItemWidget(
            index: index,
            posterPath: posterPath,
            movie: popularMovie,
            popularMovieModel: popularMovieModel,
          ),
        );
      },
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
  final MovieListData movie;
  final MovieListViewModel? popularMovieModel;

  @override
  Widget build(BuildContext context) {
    final popularMovieModel = context.watch<MovieListViewModel>();
    final popularMovie = popularMovieModel.movies[index];
    final posterPath = popularMovie.posterPath;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 20.0, right: 10.0),
      child: Container(
        height: 200,
        width: 114,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          // color: AppColors.movieBorderLine,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: FittedBox(
          child: posterPath != null ? Image.network(ImageDownloader.imageUrl(posterPath)) : const SizedBox.shrink(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// TODO: may be change to stateless widget
class _TopRatedMovieWidget extends StatefulWidget {
  const _TopRatedMovieWidget({Key? key}) : super(key: key);

  @override
  State<_TopRatedMovieWidget> createState() => _TopRatedMovieWidgetState();
}

class _TopRatedMovieWidgetState extends State<_TopRatedMovieWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TopRatedMovieModel>().setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    final topRatedMovieModel = context.watch<TopRatedMovieModel>();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: topRatedMovieModel.movies.length,
      itemBuilder: (BuildContext context, int index) {
        // topRatedMovieModel.searchTopRatedMovie();
        final topMovie = topRatedMovieModel.movies[index];
        final backdropPath = topMovie.backdropPath;
        return Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Container(
            width: 320,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: InkWell(
              onTap: () => topRatedMovieModel.onMovieTap(context, index),
              child: backdropPath != null
                  // TODO: may be wrap in fitted box
                  ? Image.network(ImageDownloader.imageUrl(backdropPath))
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}
