// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:comics_db_app/ui/components/custom_details_appbar_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/cast_and_crew.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/description_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/peoples_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/components/top_poster_widget.dart';
import 'package:comics_db_app/ui/widgets/movie_details/movie_details_cubit.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    context.read<MovieDetailsCubit>().setupMovieDetailsLocale(context, locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<MovieDetailsCubit>();
    final favorite = cubit.state.isFavorite;

    Widget fab(VoidCallback onPressed) {
      return FloatingActionButton(
        elevation: 0.0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(35.0))),
        backgroundColor: Colors.pinkAccent,
        onPressed: onPressed,
        child: favorite ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
      );
    }

    return Scaffold(
      appBar: const CustomDetailsAppBar(title: 'Movie Details'),
      floatingActionButton: fab(() => cubit.toggleFavoriteMovie(context)),
      body: ListView(
        children: [
          Column(
            children: const [
              MovieTopPosterWidget(),
              PeoplesWidget(),
              DescriptionWidget(),

              // TODO doesn't work, the request contains an invalid parameter value, need microtask
              // TrailerWidget(youtubeKey: trailerKey),

              CastWidget(),
              // const MovieSimilarWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
