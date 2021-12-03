import 'package:flutter/material.dart';
import 'package:histo_view/model/current_user.dart';
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
  final CurrentUser _user = CurrentUser();
  final _viewModel = FavoriteReviewViewModel();
  bool _isLoadFavoriteReviews = false;

  @override
  void initState() {
    super.initState();
    _getFavoritesReviews(_user.email);
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoadFavoriteReviews
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _favoriteReviewList.length + 1,
            itemBuilder: (context, index) {
              if (_favoriteReviewList.isEmpty) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                          child: Text('Favorite Reviews',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                          "You don't have any favorite review at this moment.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 20,
                            fontFamily: 'OpenSans',
                          )),
                    )
                  ],
                );
              }
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
                    isFavorite: true,
                    isMap: false,
                    refreshParent: () {
                      //remove review from favorites
                      _favoriteReviewList.removeAt(index - 1);
                      setState(() {});
                    },
                  ));
            });
  }

  // get favorites reviews from DB
  Future<void> _getFavoritesReviews(String email) async {
    List<Review> result = await _viewModel.getFavoritesReviews(email);
    setState(() {
      _favoriteReviewList = result;
      _isLoadFavoriteReviews = true;
    });
  }
}
