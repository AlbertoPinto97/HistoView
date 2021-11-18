import 'package:flutter/material.dart';
import 'package:histo_view/shared/review_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: const [
      SizedBox(
        height: 25,
      ),
      Center(
          child: Text('Favorite Reviews',
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w500))),
      SizedBox(
        height: 25,
      ),
      Review(),
      SizedBox(
        height: 25,
      ),
      Review(),
      SizedBox(
        height: 25,
      ),
    ]);
  }
}
