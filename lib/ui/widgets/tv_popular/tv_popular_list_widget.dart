// Flutter imports:
import 'package:comics_db_app/ui/widgets/settings/model_theme.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:comics_db_app/app_colors.dart';
import 'package:comics_db_app/domain/api_client/image_downloader.dart';
import 'package:comics_db_app/resources/resources.dart';
import 'package:comics_db_app/ui/components/custom_details_appbar_widget.dart';
import 'package:comics_db_app/ui/components/custom_movie_list_box_decoration_widgets.dart';
import 'package:comics_db_app/ui/components/custom_cast_list_text_widget.dart';
import 'package:comics_db_app/ui/components/custom_search_bar_widget.dart';
import 'package:comics_db_app/ui/widgets/tv_list/components/tv_list_data.dart';
import 'package:comics_db_app/ui/widgets/tv_list/tv_popular_list_cubit.dart';
import 'package:provider/provider.dart';

class TvPopularListWidget extends StatefulWidget {
  const TvPopularListWidget({Key? key}) : super(key: key);

  @override
  State<TvPopularListWidget> createState() => _TvPopularListWidgetState();
}

class _TvPopularListWidgetState extends State<TvPopularListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final locale = Localizations.localeOf(context);
    context
        .read<TvPopularListCubit>()
        .setupPopularTvLocale(locale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<TvPopularListCubit>();
    return Scaffold(
      appBar: const CustomDetailsAppBar(title: 'Popular Tvs'),
      body: Consumer<ModelTheme>(
        builder: (context, ModelTheme notifierTheme, child) {
          return ColoredBox(
            color:
                notifierTheme.isDark ? AppColors.kPrimaryColor : Colors.white70,
            child: Stack(
              children: [
                ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.only(top: 70.0),
                    itemCount: cubit.state.tvs.length,
                    itemExtent: 165,
                    itemBuilder: (BuildContext context, int index) {
                      cubit.showedPopularTvAtIndex(index);
                      final tv = cubit.state.tvs[index];
                      final posterPath = tv.posterPath;
                      return InkWell(
                        onTap: () => cubit.onTvTap(context, index),
                        child: _TvPopularListRowWidget(
                            posterPath: posterPath,
                            tv: tv,
                            cubit: cubit,
                            index: index),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: CustomSearchBar(onChanged: cubit.searchPopularTv),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TvPopularListRowWidget extends StatelessWidget {
  final int index;

  const _TvPopularListRowWidget({
    Key? key,
    required this.posterPath,
    required this.tv,
    required this.cubit,
    required this.index,
  }) : super(key: key);

  final String? posterPath;
  final TvListData tv;
  final TvPopularListCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
      builder: (context, ModelTheme notifierTheme, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Stack(
            children: [
              Container(
                // TODO refactoring custom movie list box decoration
                decoration: notifierTheme.isDark
                    ? customMovieListBoxDecorationForDarkTheme
                    : customMovieListBoxDecorationForLightTheme,
                clipBehavior: Clip.hardEdge,
                child: Row(
                  children: [
                    posterPath != null
                        ? Image.network(
                            ImageDownloader.imageUrl(posterPath!),
                            width: 95,
                          )
                        : Image.asset(AppImages.noImageAvailable),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          CustomCastListTextWidget(
                            text: tv.name,
                            maxLines: 1,
                            fontSize: null,
                            color: notifierTheme.isDark
                                ? Colors.white
                                : AppColors.kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5.0),
                          CustomCastListTextWidget(
                            text: tv.firstAirDate ?? 'No date',
                            maxLines: 1,
                            fontSize: 13,
                            color: notifierTheme.isDark
                                ? AppColors.genresText
                                : AppColors.kPrimaryColor,
                            fontWeight: null,
                          ),
                          const SizedBox(height: 15.0),
                          CustomCastListTextWidget(
                            text: tv.overview,
                            maxLines: 3,
                            fontSize: 12,
                            color: notifierTheme.isDark
                                ? AppColors.genresText
                                : AppColors.kPrimaryColor,
                            fontWeight: null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15.0),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
