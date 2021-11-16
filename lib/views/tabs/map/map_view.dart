import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histo_view/views/tabs/map/search/search_bar.dart';
import 'package:histo_view/views/tabs/map/search/search_screen.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  bool _isSearching = false;
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
  }

  void setBool(bool value) {
    setState(() {
      _isSearching = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const GoogleMap(initialCameraPosition: _initialPosition),
      if (_isSearching) const SearchScreen(),
      //Search Bar
      SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: SearchBar(
          _isSearching,
          setBool,
        ),
      )
    ]);
  }
}
