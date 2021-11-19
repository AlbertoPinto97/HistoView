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
    return Scaffold(
      body: Stack(children: [
        const GoogleMap(
          initialCameraPosition: _initialPosition,
          zoomControlsEnabled: false,
        ),
        if (_isSearching) const SearchScreen(),
        //Search Bar
        SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: SearchBar(
            _isSearching,
            setBool,
          ),
        ),
      ]),
      //Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (_) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(45.0))),
                    title: const Center(
                        child: Text(
                      'New Review',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold),
                    )),
                    content: SizedBox(
                      height: 400,
                      child: ListView(
                        children: [
                          //Name
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Name',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const TextField(
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(isDense: true),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //Period
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Period',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const TextField(
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(isDense: true),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //Topic
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Topic',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const TextField(
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(isDense: true),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //Description
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Description',
                              style: TextStyle(
                                fontFamily: 'OpenSans',
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const TextField(
                            minLines: 10,
                            maxLines: 10,
                            style: TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //Button
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.orange),
                                ),
                                onPressed: () {
                                  print('create review');
                                },
                                child: const Text(
                                  'Create Review',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
