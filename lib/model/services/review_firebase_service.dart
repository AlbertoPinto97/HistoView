import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:histo_view/model/review.dart';

// class used to connect to the DB and manage reviews
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
    FirebaseFirestore.instance.collection('reviews').add({
      '_email': email,
      '_id': id,
      'countRate': review.countRate,
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
}
