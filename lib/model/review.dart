import 'package:histo_view/model/user.dart';

//Model used for Reviews
class Review {
  int id;
  String name;
  String creationDate;
  String periodDate;
  String locationCity;
  String locationCountry;
  String creatorEmail;
  double starRate;
  String description;
  User creator;
  double latitude;
  double longitude;

  Review(
      this.id,
      this.name,
      this.creationDate,
      this.periodDate,
      this.locationCity,
      this.locationCountry,
      this.creatorEmail,
      this.starRate,
      this.description,
      this.creator,
      this.latitude,
      this.longitude);
}
