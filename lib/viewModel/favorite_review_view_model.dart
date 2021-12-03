import 'package:histo_view/model/services/review_firebase_service.dart';
import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';

class FavoriteReviewViewModel {
  Future<List<Review>> getFavoritesReviews(String email) async {
    List<Review> reviewList = [];

    // get favorite reviews relation
    final favoriteReviews =
        await ReviewFireBaseService().getFavoritesReviews(email);
    for (var favoriteReview in favoriteReviews.docs) {
      // id from user's favorite reviews
      int id = favoriteReview.data()['_reviewId'];
      // gets favorite reviews
      final reviews = await ReviewFireBaseService().getReviewById(id);

      for (var review in reviews.docs) {
        final reviewDB = review.data();
        // gets the user that has created the review
        final user =
            await UserFireBaseService().getUserByEmail(reviewDB['_email']);
        var userDB = user.docs[0].data();
        User creator = User(userDB['_email'], userDB['name'],
            userDB['followers'], userDB['following'], userDB['presentation']);
        // A favorite review
        reviewList.add(Review(
          reviewDB['_id'],
          reviewDB['name'],
          reviewDB['creationDate'],
          reviewDB['periodDate'],
          reviewDB['locationCity'],
          reviewDB['locationCountry'],
          reviewDB['_email'],
          reviewDB['starRate'].toDouble(),
          reviewDB['countRate'],
          reviewDB['description'],
          creator,
          reviewDB['latitude'],
          reviewDB['longitude'],
        ));
      }
    }
    return reviewList;
  }

  void addFavoriteReview(String email, int id) {
    ReviewFireBaseService().addFavoriteReview(email, id);
  }

  void removeFavoriteReview(String email, int id) {
    ReviewFireBaseService().removeFavoriteReview(email, id);
  }
}
