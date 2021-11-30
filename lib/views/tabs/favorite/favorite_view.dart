import 'package:flutter/material.dart';
import 'package:histo_view/model/user.dart';
import 'package:histo_view/shared/review_widget.dart';
import 'package:histo_view/viewModel/favorite_review_view_model.dart';
import 'package:histo_view/model/review.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  List<Review> _favoriteReviewList = [];
  User user = User();
  final _viewModel = FavoriteReviewViewModel();

  Future<void> getFavoritesReviews(String email) async {
    List<Review> result = await _viewModel.getFavoritesReviews(email);
    setState(() {
      _favoriteReviewList = result;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavoritesReviews(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _favoriteReviewList.length + 1,
        itemBuilder: (context, index) {
          // Title first
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text('Favorite Reviews',
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold))),
            );
          }
          // Reviews after title
          return Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: ReviewWidget(
                review: _favoriteReviewList[index - 1],
                ownReview: false,
                isMap: false,
              ));
        });
  }
}
