import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/review.dart';

// class used to connect to the DB and manage reviews/favorites reviews
class ReviewFireBaseService {
  getAllReviews() async {
    return await FirebaseFirestore.instance.collection('reviews').get();
  }

  getFavoritesReviews(String email) async {
    return await FirebaseFirestore.instance
        .collection('favoriteReviews')
        .where('_userEmail', isEqualTo: email)
        .get();
  }

  getReviewById(int id) async {
    return await FirebaseFirestore.instance
        .collection('reviews')
        .where('_id', isEqualTo: id)
        .get();
  }

  getFavoriteReviewById(String email, int id) async {
    return await FirebaseFirestore.instance
        .collection('favoriteReviews')
        .doc(email + '_' + id.toString())
        .get();
  }

  getReviewByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection('reviews')
        .where('_email', isEqualTo: email)
        .get();
  }

  getReviewMaxId() {
    return FirebaseFirestore.instance
        .collection('reviews')
        .orderBy('_id', descending: true)
        .get();
  }

  void createReview(Review review, String email, int id) {
    FirebaseFirestore.instance.collection('reviews').doc(id.toString()).set({
      '_email': email,
      '_id': id,
      'creationDate': review.creationDate,
      'description': review.description,
      'locationCity': review.locationCity,
      'locationCountry': review.locationCountry,
      'name': review.name,
      'periodDate': review.periodDate,
      'starRate': review.starRate,
      'latitude': review.latitude,
      'longitude': review.longitude
    });
  }

  void addFavoriteReview(String email, int id) {
    FirebaseFirestore.instance
        .collection('favoriteReviews')
        .doc(email + '_' + id.toString())
        .set({
      '_userEmail': email,
      '_reviewId': id,
    });
  }

  void removeFavoriteReview(String email, int id) {
    FirebaseFirestore.instance
        .collection('favoriteReviews')
        .doc(email + '_' + id.toString())
        .delete();
  }

  void rateReview(String email, int id, int stars) {
    FirebaseFirestore.instance
        .collection('ratesReview')
        .doc(email + '_' + id.toString())
        .set({'_userEmail': email, '_reviewId': id, 'stars': stars});
  }

  getRatesReviewById(int id) async {
    return await FirebaseFirestore.instance
        .collection('ratesReview')
        .where('_reviewId', isEqualTo: id)
        .get();
  }

  void setReviewStarRate(String email, int id, double rate) {
    FirebaseFirestore.instance
        .collection('reviews')
        .doc(id.toString())
        .update({'starRate': rate});
  }
}
