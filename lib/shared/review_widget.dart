import 'package:flutter/material.dart';

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: const [
                  Icon(Icons.person_sharp),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Jordi Sintes Barberà',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ],
              ),
              // YEAR OF CREATION
              const Text(
                '31 DEC 2021',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'OpenSans',
                ),
              )
            ],
          ),
          //STARS
          Row(
            children: const [
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent),
              Icon(Icons.star, color: Colors.yellowAccent)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          // TITLE AND PERIOD
          Row(
            children: const [
              Text(
                'Fall of Constantinople (1453)',
                style: TextStyle(
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
          const Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            style: TextStyle(
              fontFamily: 'OpenSans',
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
                children: const [
                  Icon(Icons.location_pin),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Istambul (Turkey)',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                    ),
                  )
                ],
              ),
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
}
