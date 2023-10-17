import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRating extends StatelessWidget {
  double rating;
  int review;
  bool useReview;

  CustomRating({@required this.rating, this.review, this.useReview = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 15,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizedBox(width: 5),
        Text(
          rating.toString(),
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ],
    );
  }
}
