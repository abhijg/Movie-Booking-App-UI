import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/movie_card.dart';

final List<String> movieListBack = [
  'assets/images/Angamaly daiaries back.jpg',
  'assets/images/leo back.jpg',
  'assets/images/kanguva_back.jpeg',
  'assets/images/SPADIKAM_back.jpg',
  'assets/images/NPNM_back.jpg',
];

final List<Map<String, dynamic>> movieList = [
  {
    'movie': 'Angamaly Daiaries',
    'poster': 'assets/images/Angamaly-Diaries.jpg',
  },
  {
    'movie': 'Leo',
    'poster': 'assets/images/leo.jpg',
  },
  {
    'movie': 'Kanguva',
    'poster': 'assets/images/kanguva.jpg',
  },
  {
    'movie': 'Spadikam',
    'poster': 'assets/images/SPADIKAM.jpeg',
  },
  {
    'movie': 'NPNM',
    'poster': 'assets/images/NPNM.jpg',
  },
];

final List<Widget> imageSliders =
    movieList.map((item) => Container(child: MovieCard(item))).toList();

class FullscreenSliderDemo extends StatefulWidget {
  @override
  _FullscreenSliderDemoState createState() => _FullscreenSliderDemoState();
}

class _FullscreenSliderDemoState extends State<FullscreenSliderDemo> {
  CarouselController buttonCarouselController = CarouselController();
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                controller: _scrollController,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: movieListBack.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: new BoxDecoration(
                        color: Colors.black12,
                        image: new DecorationImage(
                          image: new ExactAssetImage(movieListBack[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.6)),
                      ));
                }),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              aspectRatio: 2,
              carouselController: buttonCarouselController,
              viewportFraction: 0.68,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onScrolled: (data) {
                _scrollController.animateTo(
                  ((data * 125 / imageSliders.length) / 100) *
                      _scrollController.position.maxScrollExtent,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
            items: imageSliders,
          ),
        ],
      ),
      floatingActionButton: ButtonTheme(
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.amber[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () {
            print(_scrollController.position.maxScrollExtent);
          },
          child: Text("Book now".toUpperCase(), style: TextStyle(fontSize: 14)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
