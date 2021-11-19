import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tabBar');
                  },
                ),
                const Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.done,
                    color: Colors.orange,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/tabBar');
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Icon(
              Icons.person,
              size: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                "Change profile's photo",
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            //NAME
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Name',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    color: Colors.grey.shade700),
              ),
            ),
            const TextField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(isDense: true),
            ),
            const SizedBox(
              height: 25,
            ),
            //Email
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Email',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    color: Colors.grey.shade700),
              ),
            ),
            const TextField(
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(isDense: true),
            ),
            const SizedBox(
              height: 25,
            ),
            //Presentation
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Presentation',
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              minLines: 10,
              maxLines: 10,
              style: TextStyle(fontSize: 15),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
