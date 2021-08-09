import 'package:comics_db_app/app_colors.dart';
import 'package:comics_db_app/widgets/auth/auth_widget.dart';
import 'package:comics_db_app/widgets/main_screen/main_screen.dart';
import 'package:comics_db_app/widgets/movie_details/movie_details_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: Colors.grey),
      ),
      routes: {
        '/auth': (context) => const AuthWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
        'main_screen/movie_details': (context) => const MovieDetailsWidget(),
      },
      initialRoute: '/auth',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
              body: Center(child: Text('Произошла ошибка навигации')));
        });
      },
    );
  }
}
