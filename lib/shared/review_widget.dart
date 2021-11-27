import 'package:flutter/material.dart';
import 'package:histo_view/model/review.dart';

class ReviewWidget extends StatelessWidget {
  final Review review;
  final bool ownReview;

  const ReviewWidget({Key? key, required this.review, required this.ownReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = review.name + " (" + review.periodDate + ")";
    String location = review.locationCity + " (" + review.locationCountry + ")";
    bool needHalfStar = halfStar(review.starRate);
    //TODO: LIKE SYSTEM
    //TODO: redirect user when his name it's clicked
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
          color: Colors.orange.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(45))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ICON/PHOTO + NAME
              GestureDetector(
                onTap: () {
                  if (!ownReview) {
                    // go to creator's profile
                    Navigator.pushNamed(context, '/profile',
                        arguments: review.creator);
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.person_sharp),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        review.creator.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // YEAR OF CREATION
              Text(
                review.creationDate,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                ),
              )
            ],
          ),
          //STARS
          Row(
            children: [
              for (var i = 0; i < review.starRate.toInt(); i++)
                const Icon(
                  Icons.star,
                  color: Colors.yellowAccent,
                  size: 30,
                ),
              // adds half star
              if (needHalfStar)
                const Icon(
                  Icons.star_half,
                  color: Colors.yellowAccent,
                  size: 30,
                ),
              // adds void stars until 5 stars (having half star)
              if (5 - review.starRate.toInt() > 0 && needHalfStar)
                for (var i = 1; i < 5 - review.starRate.toInt(); i++)
                  const Icon(
                    Icons.star_border,
                    color: Colors.yellowAccent,
                    size: 30,
                  ),
              // adds void stars until 5 stars (not having half star)
              if (5 - review.starRate.toInt() > 0 && !needHalfStar)
                for (var i = 0; i < 5 - review.starRate.toInt(); i++)
                  const Icon(
                    Icons.star_border,
                    color: Colors.yellowAccent,
                    size: 30,
                  ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // TITLE AND PERIOD
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'OpenSans',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          // DESCRIPTION
          Text(
            review.description,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // LOCATION AND FAVORITE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                    ),
                  )
                ],
              ),
              if (!ownReview)
                const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
            ],
          )
        ],
      ),
    );
  }

  // rounds values to .0 and 0.5
  bool halfStar(double value) {
    double newValue = value * 2;
    newValue = newValue.round() / 2;
    if (newValue > value) return true;
    return false;
  }
}
