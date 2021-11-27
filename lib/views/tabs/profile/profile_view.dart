import 'package:flutter/material.dart';
import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/model/user_profile.dart';
import 'package:histo_view/shared/review_widget.dart';
import 'package:histo_view/viewModel/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  final bool isOwnProfile;

  const ProfileView({Key? key, required this.isOwnProfile}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<NavigatorState> _key = GlobalKey();
  List<Review> _reviewList = [];
  final User _user = User();
  late UserProfile _userProfile;
  final _viewModel = ProfileViewModel();
  int _numberReviews = 0;
  bool _isFollowed = false;

  Future<void> getReviews() async {
    if (ModalRoute.of(context)!.settings.arguments != null &&
        !widget.isOwnProfile) {
      _userProfile = ModalRoute.of(context)!.settings.arguments as UserProfile;
    } else {
      _userProfile = UserProfile(_user.email, _user.userName, _user.followers,
          _user.following, _user.presentation);
    }
    var result = await _viewModel.getUserReviews(_userProfile);
    if (mounted) {
      setState(() {
        _reviewList = result;
        _numberReviews = result.length;
      });
    }
  }

  Future<void> checkIfUserIsFollowed() async {
    bool result = await _viewModel.isFollowing(_user.email, _userProfile.email);
    if (mounted) {
      setState(() {
        _isFollowed = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getReviews();
    if (!widget.isOwnProfile) {
      checkIfUserIsFollowed();
      return otherProfile();
    }
    return ownProfile();
  }

  Widget otherProfile() {
    return WillPopScope(
      onWillPop: () async {
        _key.currentState?.maybePop();
        return true;
      },
      child: Scaffold(
        body: ListView(children: [
          Row(children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            const Text('Profile',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold))
          ]),
          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                size: 120,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PROFILE'S NAME
                  SizedBox(
                    width: 220,
                    child: Text(_userProfile.userName,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // BUTTON FOLLOW
                  SizedBox(
                    height: 50,
                    width: 135,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(20),
                          shape: _isFollowed
                              // is Following
                              ? MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.orange),
                                  borderRadius: BorderRadius.circular(45.0),
                                ))
                              // is not Following
                              : MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0),
                                )),
                          backgroundColor: _isFollowed
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(Colors.orange),
                        ),
                        onPressed: () async {
                          if (_isFollowed) {
                            await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text('Do you want to unfollow?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      //unfollow user
                                      _viewModel.unfollowUser(
                                          _user.email, _userProfile.email);
                                      if (_userProfile.followers > 0) {
                                        _userProfile.followers--;
                                      }
                                      if (_user.following > 0) {
                                        _user.following--;
                                      }
                                      _isFollowed = false;
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // follow user
                            _viewModel.followUser(
                                _user.email, _userProfile.email);
                            _userProfile.followers++;
                            _user.following++;
                            _isFollowed = true;
                          }
                        },
                        child: _isFollowed
                            ? const Text(
                                'Following',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'OpenSans',
                                    color: Colors.orange),
                              )
                            : Row(
                                children: const [
                                  Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Follow',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'OpenSans',
                                        color: Colors.white),
                                  )
                                ],
                              )),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Reviews
              Column(
                children: [
                  Text(
                    _numberReviews.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
                  ),
                ],
              ),
              //Followers
              Column(
                children: [
                  Text(
                    _userProfile.followers.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Followers',
                    style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
                  ),
                ],
              ),
              //Following
              Column(
                children: [
                  Text(
                    _userProfile.following.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Following',
                    style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          //PRESENTATION
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              'Presentation',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //PRESENTATION TEXT
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              _userProfile.presentation,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // User's reviews
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _reviewList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ReviewWidget(
                    review: _reviewList[index],
                    ownReview: true,
                  ),
                );
              })
        ]),
      ),
    );
  }

  Widget ownProfile() {
    return ListView(children: [
      const SizedBox(
        height: 25,
      ),
      Row(
        children: [
          const Icon(
            Icons.person_outline_rounded,
            size: 120,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //PROFILE'S NAME
              SizedBox(
                width: 220,
                child: Text(_userProfile.userName,
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10,
              ),
              // BUTTON EDIT PROFILE
              SizedBox(
                height: 50,
                width: 170,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(20),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/editProfile');
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'OpenSans',
                              color: Colors.white),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Reviews
          Column(
            children: [
              Text(
                _numberReviews.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
              ),
            ],
          ),
          //Followers
          Column(
            children: [
              Text(
                _userProfile.followers.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Followers',
                style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
              ),
            ],
          ),
          //Following
          Column(
            children: [
              Text(
                _userProfile.following.toString(),
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Following',
                style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      //PRESENTATION
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: const Text(
          'Presentation',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      //PRESENTATION TEXT
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          _userProfile.presentation,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      // User's reviews
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _reviewList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ReviewWidget(
                review: _reviewList[index],
                ownReview: true,
              ),
            );
          })
    ]);
  }
}
