import 'package:flutter/material.dart';
import 'package:histo_view/views/tabs/favorite_view.dart';
import 'package:histo_view/views/tabs/map/map_view.dart';
import 'package:histo_view/views/tabs/profile_view.dart';

class TabBarAppView extends StatefulWidget {
  const TabBarAppView({Key? key}) : super(key: key);

  @override
  State<TabBarAppView> createState() => _TabBarAppViewState();
}

class _TabBarAppViewState extends State<TabBarAppView> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    FavoriteView(),
    MapView(),
    ProfileView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.orange,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
