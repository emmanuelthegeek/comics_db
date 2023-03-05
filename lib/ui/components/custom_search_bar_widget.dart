// Flutter imports:
import 'package:comics_db_app/core/dark_theme_colors.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:comics_db_app/ui/components/custom_search_input_decoration_widget.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String)? onChanged;

  const CustomSearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO check may be delete consumer, because it's only change text color
    return TextField(
      style: const TextStyle(
        color: DarkThemeColors.genresText,
      ),
      onChanged: onChanged,
      decoration: customSearchInputDecoration(text: 'Search'),
    );
  }
}
