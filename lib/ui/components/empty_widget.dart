import 'package:flutter/material.dart';

enum EmptyWidgetType { cart, favorite }

class EmptyWidget extends StatelessWidget {
  final EmptyWidgetType type;
  final String title;
  final bool condition;
  final Widget child;

  const EmptyWidget({
    Key? key,
    this.type = EmptyWidgetType.cart,
    required this.title,
    this.condition = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition
        ? child
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                type == EmptyWidgetType.cart
                    // ? Image.asset(AppAsset.emptyCart, width: 300)
                    // : Image.asset(AppAsset.emptyFavorite, width: 300),
                    ? const Text('no cart yet')
                    : const Text('no favorites yet'),
                const SizedBox(height: 10.0),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          );
  }
}
