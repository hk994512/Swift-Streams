import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../helper/ui_helper.dart';

Widget get flipImages {
  final images = [
    'https://canvas.tamashaweb.com/jazzlive/uploads/channels/1755120393242.webp?id=17',
    'https://canvas.tamashaweb.com/jazzlive/uploads/channels/1754939494851.webp?id=48',
    'https://canvas.tamashaweb.com/jazzlive/uploads/channels/1755478267575.webp?id=25',
    'https://d34080pnh6e62j.cloudfront.net/images/VideoOnDemandCategorythumb/17368551091080x1920-thumbnail.jpg-1.jpg',
    'https://d34080pnh6e62j.cloudfront.net/images/contentCategorythumb/1755165062_1600x2130.jpg',
    'https://d34080pnh6e62j.cloudfront.net/images/NewVideoOnDemandThumb/1753982727_324x432.jpg',
  ];
  return CarouselSlider(
    options: CarouselOptions(
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 16 / 9,
      initialPage: 3,
      autoPlayCurve: Curves.easeOutBack,
      height: 175.0,
    ),
    items:
        images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height - 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: UIHelper.image(i, fit: BoxFit.fill, isAsset: false),
              );
            },
          );
        }).toList(),
  );
}
