import 'package:comics_db_app/app_colors.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/description_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/peoples_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/top_poster_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/trailer_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  @override
  _MovieDetailsWidgetState createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() =>

    // final locale = Localizations.localeOf(context);
    // context.read<MovieDetailsCubit>().setupLocale(locale.languageCode);
    context.read<MovieDetailsCubit>().setupMovieDetailsLocale(context),
    );
    // Future.microtask(
    //   () => context.read<MovieDetailsCubit>().setupLocale(context, locale),
    // );
    // context.read<MovieListCubit>().setupPopularMovieLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading = context.select((MovieDetailsModel model) => model.data.isLoading);
    // final cubit = context.watch<MovieDetailsCubit>();

    // if (isLoading) {
    //   return const Center(
    //     child: LoadingIndicatorWidget(),
    //   );
    // }
    // var trailerData = context.select((MovieDetailsModel model) => model.data.trailerData);
    // final trailerKey = trailerData.trailerKey;

    final cubit = context.watch<MovieDetailsCubit>();
    final trailerKey = cubit.state.trailerKey;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movie Details'),
      ),
      body: ColoredBox(
        color: AppColors.kPrimaryColor,
        child: ListView(children: [
          Column(
            children: [
              const MovieTopPosterWidget(),
              // const PeoplesWidget(),
              const DescriptionWidget(),
              // TrailerWidget(youtubeKey: trailerKey),
              // const CastWidget(),
              // const MovieSimilarWidget(),
            ],
          ),
        ]),
      ),
    );
  }
}
