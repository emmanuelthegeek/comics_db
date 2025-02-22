// Flutter imports:
import 'package:comics_db_app/core/dark_theme_colors.dart';
import 'package:comics_db_app/domain/blocs/theme/theme_bloc.dart';
import 'package:comics_db_app/ui/components/page_transition.dart';
import 'package:comics_db_app/ui/widgets/account/account_widget.dart';
import 'package:comics_db_app/ui/widgets/favorite_screen/favorite_movie_list_widget.dart';
import 'package:comics_db_app/ui/widgets/people_widget/popular_people_list_widget.dart';
import 'package:comics_db_app/ui/widgets/tv_list/tv_list_widget.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

// Project imports:
import 'package:comics_db_app/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainScreenWidget extends HookWidget {
  MainScreenWidget({Key? key}) : super(key: key);

  final List<Widget> screen = [
    const PopularPeopleListWidget(),
    const MovieListWidget(),
    const TvListWidget(),
    const FavoriteMovieListWidget(),
    const AccountWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(1);
    bool isDarkTheme = context.read<ThemeBloc>().isDarkTheme;
    return Scaffold(
      body: PageTransition(child: screen[selectedIndex.value]),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: isDarkTheme ? DarkThemeColors.bottomBarBackgroundColor : Colors.white,
        color: isDarkTheme ? Colors.white : Colors.black.withOpacity(0.7),
        shadowColor: isDarkTheme ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4),
        activeColor: isDarkTheme ? Colors.white : Colors.black.withOpacity(0.8),
        initialActiveIndex: selectedIndex.value,
        items: const [
          TabItem<dynamic>(icon: Icons.people, title: 'People'),
          TabItem<dynamic>(icon: Icons.movie, title: 'Movie'),
          TabItem<dynamic>(icon: Icons.tv, title: 'TV'),
          TabItem<dynamic>(icon: Icons.favorite_outline, title: 'Favorites'),
          TabItem<dynamic>(icon: Icons.settings, title: 'Personal'),
        ],
        onTap: (int index) => selectedIndex.value = index,
      ),
    );
  }
}
