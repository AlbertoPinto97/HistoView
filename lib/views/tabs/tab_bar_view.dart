import 'package:flutter/material.dart';
import 'package:histo_view/views/tabs/favorite/favorite_view.dart';
import 'package:histo_view/views/tabs/map/map_view.dart';
import 'package:histo_view/views/tabs/profile/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabBarAppView extends StatefulWidget {
  const TabBarAppView({Key? key}) : super(key: key);

  @override
  State<TabBarAppView> createState() => _TabBarAppViewState();
}

class _TabBarAppViewState extends State<TabBarAppView> {
  int _selectedIndex = 1; // index of the default screen for the bottom tabs
  final List<Widget> _widgetOptions = <Widget>[
    const FavoriteView(), // 0
    const MapView(), // 1
    const ProfileView(isOwnProfile: true) // 2
  ];

  // changes the screen
  void _onItemTapped(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _selectedIndex = ModalRoute.of(context)!.settings.arguments as int;
    }
    return DefaultTabController(
      length: 3,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.orange.shade100,
            items: const <BottomNavigationBarItem>[
              // Favorite bottom bar
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              // Favorite map bar
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              // Favorite profile bar
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.orange.shade700,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

// Go back to login (logout)
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => logout(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //clear all sharedPrefenreces
    await prefs.clear();
    Navigator.pushNamed(context, '/login');
  }
}
