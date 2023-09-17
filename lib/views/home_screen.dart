import 'package:dtt_view_houses_app/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'information_screen.dart';
import 'overview_screen.dart';
import 'wishlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    OverViewScreen(),
    WishlistScreen(),
    InformationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.dark_mode),
              trailing: Switch(
                value: context.watch<ThemeController>().isDarkMode,
                onChanged: (value) {
                  context.read<ThemeController>().toggleDarkMode();
                },
              ),
              title: Text('Dark mode'),
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        currentIndex: _currentPage,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: '',
          )
        ],
      ),
      body: _pages[_currentPage],
    );
  }
}
