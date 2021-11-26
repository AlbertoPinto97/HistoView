import 'package:histo_view/model/services/review_firebase_service.dart';
import 'package:histo_view/model/review.dart';

class FavoriteReviewViewModel {
  Future<List<Review>> getFavoritesReviews(String email) async {
    List<Review> reviewList = [];
    // get favorite reviews relation
    final favoriteReviews =
        await ReviewFireBaseService().getFavoritesReviews(email);
    for (var favoriteReview in favoriteReviews.docs) {
      // id from user's favorite reviews
      int id = favoriteReview.data()['_review_id'];
      // getting favorite reviews
      final reviews = await ReviewFireBaseService().getReviewById(id);
      for (var review in reviews.docs) {
        final reviewDB = review.data();
        reviewList.add(Review(
            reviewDB['name'],
            reviewDB['creation_date'],
            reviewDB['period_date'],
            reviewDB['location_city'],
            reviewDB['location_country'],
            reviewDB['_email'],
            reviewDB['star_rate'].toDouble(),
            reviewDB['count_rate'],
            reviewDB['description'],
            reviewDB['creator_name']));
      }
    }
    return reviewList;
  }
}
