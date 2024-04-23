import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ListOfImages extends StatefulWidget {
  const ListOfImages({Key? key}) : super(key: key);

  @override
  State<ListOfImages> createState() => _ListOfImagesState();
}

class _ListOfImagesState extends State<ListOfImages> {
  CarouselController buttonCarouselController = CarouselController();

  List<String> imagePaths = [
    "https://as2.ftcdn.net/v2/jpg/03/10/24/63/1000_F_310246341_869grfwR1b87MN3qyFPe6yZZIRC83X31.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/10/24/63/1000_F_310246341_869grfwR1b87MN3qyFPe6yZZIRC83X31.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/10/24/63/1000_F_310246341_869grfwR1b87MN3qyFPe6yZZIRC83X31.jpg",
    "https://as2.ftcdn.net/v2/jpg/03/10/24/63/1000_F_310246341_869grfwR1b87MN3qyFPe6yZZIRC83X31.jpg",
  ];

  List<Image> images = [];

  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Create Image widgets from image paths
    images = imagePaths.map((path) => Image.network(path)).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Precache images
    for (var image in images) {
      precacheImage(image.image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Images'),
      ),
      body: Column(
        children: <Widget>[
          CarouselSlider(
            items: images,
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
          ElevatedButton(
            onPressed: () => buttonCarouselController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
            ),
            child: const Text('→'),
          ),
          Text('Current Image Index: $_currentImageIndex'),
        ],
      ),
    );
  }
}
