import 'package:flutter/material.dart';
import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/shared/review_widget.dart';
import 'package:histo_view/viewModel/profile_view_model.dart';

class ProfileView extends StatefulWidget {
  final bool isOwnProfile;

  const ProfileView({Key? key, required this.isOwnProfile}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Review> _reviewList = [];
  final User _user = User();
  final _viewModel = ProfileViewModel();

  Future<void> getReviews(String email) async {
    var result = await _viewModel.getUserReviews(email);
    setState(() {
      _reviewList = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getReviews(_user.email);
  }

  @override
  Widget build(BuildContext context) {
    final String _text = widget.isOwnProfile ? "Edit Profile" : "Follow";
    final double _buttonWidth = widget.isOwnProfile ? 170 : 135;
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
              Text(_user.userName,
                  style: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              // BUTTON EDIT PROFILE/FOLLOW
              SizedBox(
                height: 50,
                width: _buttonWidth,
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
                      if (widget.isOwnProfile) {
                        Navigator.pushNamed(context, '/editProfile');
                      }
                    },
                    child: Row(
                      children: [
                        widget.isOwnProfile
                            ? const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _text,
                          style: const TextStyle(
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
            children: const [
              Text(
                '5',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
              ),
            ],
          ),
          //Followers
          Column(
            children: [
              Text(
                _user.followers.toString(),
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
                _user.following.toString(),
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
          _user.presentation,
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
