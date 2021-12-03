import 'package:flutter/material.dart';
import 'package:histo_view/model/current_user.dart';
import 'package:histo_view/model/review.dart';
import 'package:histo_view/viewModel/favorite_review_view_model.dart';

class ReviewWidget extends StatefulWidget {
  final Review review;
  final bool ownReview;
  final bool isMap;
  final bool isFavorite;
  final Function()? callback;
  final Function()? refreshParent;

  const ReviewWidget(
      {Key? key,
      required this.review,
      required this.ownReview,
      required this.isMap,
      required this.isFavorite,
      this.callback = _dummyOnFocusChange,
      this.refreshParent})
      : super(key: key);

  static _dummyOnFocusChange() {}

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late bool _isFavorite;
  final FavoriteReviewViewModel _viewModel = FavoriteReviewViewModel();
  final CurrentUser _user = CurrentUser();

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void addToFavorite() {
    _viewModel.addFavoriteReview(_user.email, widget.review.id);
    _isFavorite = true;
    setState(() {});
  }

  void removeFromFavorite() {
    if (widget.refreshParent == null) {
      _isFavorite = false;
    } else {
      widget.refreshParent!();
    }

    _viewModel.removeFavoriteReview(_user.email, widget.review.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String _title = widget.review.name + " (" + widget.review.periodDate + ")";
    String _location =
        widget.review.locationCity + " (" + widget.review.locationCountry + ")";
    bool needHalfStar = halfStar(widget.review.starRate);
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
          if (widget.isMap)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: widget.callback, icon: const Icon(Icons.close)),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ICON/PHOTO + NAME
              GestureDetector(
                onTap: () {
                  if (!widget.ownReview) {
                    // go to creator's profile
                    Navigator.pushNamed(context, '/profile',
                        arguments: widget.review.creator);
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.person_sharp),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                        widget.review.creator.userName,
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
                widget.review.creationDate,
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
              for (var i = 0; i < widget.review.starRate.toInt(); i++)
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
              if (5 - widget.review.starRate.toInt() > 0 && needHalfStar)
                for (var i = 1; i < 5 - widget.review.starRate.toInt(); i++)
                  const Icon(
                    Icons.star_border,
                    color: Colors.yellowAccent,
                    size: 30,
                  ),
              // adds void stars until 5 stars (not having half star)
              if (5 - widget.review.starRate.toInt() > 0 && !needHalfStar)
                for (var i = 0; i < 5 - widget.review.starRate.toInt(); i++)
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
                _title,
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
            widget.review.description,
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
            children: [
              const Icon(Icons.location_pin),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: !widget.ownReview ? 180 : 200,
                child: Text(
                  _location,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
              if (!widget.ownReview && _isFavorite)
                IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: removeFromFavorite,
                ),
              if (!widget.ownReview && !_isFavorite)
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: addToFavorite,
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool halfStar(double value) {
    double newValue = value * 2;
    newValue = newValue.round() / 2;
    if (newValue > value) return true;
    return false;
  }
}
