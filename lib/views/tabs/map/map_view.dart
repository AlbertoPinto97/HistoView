import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/current_user.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/shared/review_widget.dart';
import 'package:histo_view/viewModel/map_view_model.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final _mapFormKey = GlobalKey<FormState>();
  bool _isSearching = false;
  bool _isLoadCurrentLocation = false;
  bool _isWatchingReview = false;
  bool _isOwnReview = false;
  bool _isFavorite = false;
  bool _isStatusLocationGranted = false;
  bool _showInfoMessage = true;
  bool _showCreateReview = false;
  late Review _currentReview;
  final _viewModel = MapViewModel();
  final CurrentUser _user = CurrentUser();
  late LatLng _currentLatLng;
  late LatLng _point;
  final Set<Marker> _markers = {};
  List<Review> _reviewList = [];
  String _searchTerm = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _setReviewMarks();
  }

  void _setReviewMarks() async {
    // gets all reviews
    _reviewList = await _viewModel.getAllReviews();
    for (Review review in _reviewList) {
      _createMark(LatLng(review.latitude, review.longitude), review.name,
          review.creator.userName, review.creator.email, review);
    }
  }

  Future<bool> _askPermission() async {
    return await Permission.locationWhenInUse.request().isGranted;
  }

  void _getCurrentLocation() async {
    _isStatusLocationGranted = await _askPermission();
    // if location permission is granted
    if (_isStatusLocationGranted) {
      // gets current position of the user
      Geolocator.getCurrentPosition().then((currLocation) {
        setState(() {
          _currentLatLng =
              LatLng(currLocation.latitude, currLocation.longitude);
          _isLoadCurrentLocation = true;
        });
      });
    } else {
      // default location (Barcelona)
      _currentLatLng = const LatLng(41.390205, 2.154007);
      _isLoadCurrentLocation = true;
      setState(() {});
    }
  }

//creates a mark in the map
  void _createMark(
      LatLng point, String name, String author, String email, Review review) {
    _markers.add(Marker(
      markerId: MarkerId(point.toString()),
      onTap: () async {
        _isFavorite = await _viewModel.isFavoriteReview(_user.email, review.id);
        _currentReview = review;
        _isOwnReview = email == _user.email;
        _isWatchingReview = true;
        setState(() {});
      },
      position: point,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
    if (mounted) {
      setState(() {});
    }
  }

  void _closeReview() {
    _isWatchingReview = false;
    setState(() {});
  }

  void _handleLongTap(LatLng point) {
    //popup to create reviews
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to create a review here?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              _point = point;
              _showCreateReview = true;
              setState(() {});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  //form to create a new review
  Widget _createReview() {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: Colors.white,
        child: Form(
          key: _mapFormKey,
          child: ListView(
            children: [
              const Center(
                  child: Text(
                'New Review',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
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
              TextFormField(
                validator: RequiredValidator(errorText: 'Name is required'),
                controller: _nameController,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                    isDense: true, hintText: 'Name of the review'),
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
              TextFormField(
                validator: RequiredValidator(errorText: 'Period is required'),
                controller: _periodController,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                    isDense: true, hintText: 'Age of the event e.g. 1555'),
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
              TextFormField(
                validator: RequiredValidator(errorText: 'Topic is required'),
                controller: _topicController,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                    isDense: true, hintText: 'E.g. Roman empire'),
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
              TextFormField(
                validator:
                    RequiredValidator(errorText: 'Description is required'),
                controller: _descriptionController,
                minLines: 7,
                maxLines: 7,
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  hintText: 'Description about the event',
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () async {
                      if (_mapFormKey.currentState!.validate()) {
                        //create review in the DB
                        Review newReview = await _createReviewDB(_point);
                        //Create mark
                        _createMark(_point, _nameController.text,
                            _user.userName, _user.email, newReview);
                        //reset texts
                        _nameController.text = '';
                        _descriptionController.text = '';
                        _periodController.text = '';
                        _topicController.text = '';
                        // close create review
                        _showCreateReview = false;
                        setState(() {});
                      }
                    },
                    child: const Text(
                      'Create Review',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () async {
                      _showCreateReview = false;
                      setState(() {});
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'OpenSans',
                          color: Colors.white),
                    )),
              ),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setBool(bool value) {
    setState(() {
      _isSearching = value;
    });
  }

  // called when search them changes
  void _rebuild(String searchTerm) {
    _searchTerm = searchTerm;
    setState(() {});
  }

  // search bar widget
  Widget _searchBar() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      _isSearching
          ? SizedBox(
              width: 50,
              child: IconButton(
                onPressed: () {
                  _setBool(false);
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            )
          : const SizedBox(
              width: 30,
            ),
      Container(
        height: 50,
        width: _isSearching ? 280 : 300,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(45))),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: _isSearching ? 260 : 270,
            child: SizedBox(
              child: TextField(
                onChanged: _rebuild,
                onTap: () => _setBool(true),
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  isCollapsed: false,
                  icon: _isSearching ? null : const Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search...',
                ),
              ),
              width: 235,
            ),
          ),
        ),
      ),
    ]);
  }

  // creates a review with all its information obtained in the popup
  Future<Review> _createReviewDB(LatLng point) async {
    DateTime date = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yy');
    String formattedDate = formatter.format(date);
    User creator = User(_user.email, _user.userName, _user.followers,
        _user.following, _user.presentation);
    // translates coordinates to city and country
    List<Placemark> _placemarks = await placemarkFromCoordinates(
        point.latitude, point.longitude,
        localeIdentifier: 'en_US');
    Placemark location = _placemarks.first;
    String country = location.country ?? '';
    String city = location.locality ?? '';
    // new review
    Review newReview = Review(
        0,
        _nameController.text,
        formattedDate,
        _periodController.text,
        city,
        country,
        _user.email,
        0,
        _descriptionController.text,
        creator,
        point.latitude,
        point.longitude);
    // adds the new review to the DB
    _viewModel.createReview(newReview, _user.email);
    return newReview;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // search screen
  Widget _getSearchScreen() {
    List<Review> filteredList = [];
    for (Review review in _reviewList) {
      // filters reviews by creator's name and review's name
      if (review.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
          review.creator.userName
                  .toLowerCase()
                  .contains(_searchTerm.toLowerCase()) &&
              _searchTerm.isNotEmpty) {
        // reviews filtered that matches with the search term
        filteredList.add(review);
      }
    }
    // result list
    return Container(
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 130, left: 30),
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                FocusScope.of(context).unfocus();
                _isSearching = false;
                LatLng latLng = LatLng(filteredList[index].latitude,
                    filteredList[index].longitude);
                final GoogleMapController controller = await _controller.future;
                controller
                    .animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.topLeft,
                child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filteredList[index].name,
                        style: const TextStyle(fontSize: 22),
                      ),
                      Text(
                        filteredList[index].creator.userName,
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isLoadCurrentLocation
            //current location loaded
            ? Stack(children: [
                //Google Map
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _currentLatLng, zoom: 15),
                  onMapCreated: _onMapCreated,
                  zoomControlsEnabled: false,
                  onLongPress: _handleLongTap,
                  markers: _markers,
                ),
                //Search screen
                if (_isSearching) _getSearchScreen(),
                //Search Bar
                Column(
                  children: [
                    SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: _searchBar()),
                    const SizedBox(
                      height: 15,
                    ),
                    // Info message
                    if (_showInfoMessage)
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blueAccent,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 10),
                                  width: 250,
                                  child: const Text(
                                    'To create a new review you have to long tap the map in the location where you want to create it.',
                                    style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 13,
                                        fontFamily: 'OpenSans'),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      //close info message
                                      _showInfoMessage = false;
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.blueAccent,
                                    )),
                              ],
                            )),
                      )
                  ],
                ),
                if (_isWatchingReview)
                  //Review selected
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      width: 320,
                      child: SingleChildScrollView(
                          child: ReviewWidget(
                        review: _currentReview,
                        ownReview: _isOwnReview,
                        isFavorite: _isFavorite,
                        isMap: true,
                        callback: _closeReview,
                      )),
                    ),
                  ),
                if (_showCreateReview) _createReview()
              ])
            //loading current location
            : const Center(child: CircularProgressIndicator()));
  }
}
