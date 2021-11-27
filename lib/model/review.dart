import 'package:histo_view/model/user_profile.dart';

class Review {
  String name;
  String creationDate;
  String periodDate;
  String locationCity;
  String locationCountry;
  String creatorEmail;
  double starRate;
  int countRate;
  String description;
  UserProfile creator;

  Review(
      this.name,
      this.creationDate,
      this.periodDate,
      this.locationCity,
      this.locationCountry,
      this.creatorEmail,
      this.starRate,
      this.countRate,
      this.description,
      this.creator);
}
