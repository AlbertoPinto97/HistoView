import 'package:flutter/material.dart';
import 'package:histo_view/shared/review_widget.dart';

class ProfileView extends StatelessWidget {
  final bool isOwnProfile;

  const ProfileView({Key? key, required this.isOwnProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _text = isOwnProfile ? "Edit Profile" : "Follow";
    double _buttonWidth = isOwnProfile ? 170 : 135;
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
              const Text('Jordi Sintes Barberà',
                  style: TextStyle(
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
                      if (isOwnProfile) {
                        Navigator.pushNamed(context, '/editProfile');
                      }
                    },
                    child: Row(
                      children: [
                        isOwnProfile
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
            children: const [
              Text(
                '15',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Followers',
                style: TextStyle(fontSize: 17, fontFamily: 'OpenSans'),
              ),
            ],
          ),
          //Following
          Column(
            children: const [
              Text(
                '25',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold),
              ),
              Text(
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
        child: const Text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      //const ReviewWidget(),
      const SizedBox(
        height: 25,
      ),
      //const ReviewWidget(),
      const SizedBox(
        height: 25,
      ),
    ]);
  }
}
