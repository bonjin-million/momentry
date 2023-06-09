import 'package:flutter/material.dart';
import 'package:momentry/screens/book/list/book_list_screen.dart';
import 'package:momentry/screens/movie/list/movie_list_screen.dart';
import 'package:momentry/screens/post/list/post_list_screen.dart';
import 'package:momentry/screens/setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        PostListScreen(),
        MovieListScreen(),
        BookListScreen(),
        SettingScreen(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: '일기',
          ),
          NavigationDestination(
            icon: Icon(Icons.movie_outlined),
            label: '영화',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            label: '책',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: '설정',
          ),
        ],
      ),
    );
  }
}
