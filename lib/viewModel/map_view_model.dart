import 'package:histo_view/model/review.dart';
import 'package:histo_view/model/services/review_firebase_service.dart';
import 'package:histo_view/model/services/user_firebase_service.dart';
import 'package:histo_view/model/user.dart';

class MapViewModel {
  Future<void> createReview(Review review, String email) async {
    //gets max id
    final idDB = await ReviewFireBaseService().getReviewMaxId();
    // next id (max id + 1)
    int id = 0;
    // checks if there's any id
    if (idDB.docs.length > 0) {
      id = idDB.docs[0].data()['_id'] + 1;
    }
    // create new Review in DB
    ReviewFireBaseService().createReview(review, email, id);
  }

  Future<List<Review>> getAllReviews() async {
    List<Review> reviewList = [];
    final reviewsDB = await ReviewFireBaseService().getAllReviews();
    for (var reviewDB in reviewsDB.docs) {
      // gets the user that has created the review
      final user =
          await UserFireBaseService().getUserByEmail(reviewDB['_email']);
      var userDB = user.docs[0].data();
      User creator = User(userDB['_email'], userDB['name'], userDB['followers'],
          userDB['following'], userDB['presentation']);
      reviewList.add(Review(
        reviewDB['_id'],
        reviewDB['name'],
        reviewDB['creationDate'],
        reviewDB['periodDate'],
        reviewDB['locationCity'],
        reviewDB['locationCountry'],
        reviewDB['_email'],
        reviewDB['starRate'].toDouble(),
        reviewDB['description'],
        creator,
        reviewDB['latitude'],
        reviewDB['longitude'],
      ));
    }
    return reviewList;
  }

  Future<bool> isFavoriteReview(String email, int id) async {
    bool isFavorite = false;
    final review =
        await ReviewFireBaseService().getFavoriteReviewById(email, id);
    if (review.exists) {
      isFavorite = true;
    }
    return isFavorite;
  }
}
