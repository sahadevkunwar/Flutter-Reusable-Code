import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageList = [
    "https://www.linkedhill.com.np/images/property/1660808061hotel-temple-villa.jpg",
    "https://linkedhill.com.np/images/property/1713960707interior-design-company-1-1024x602.jpg",
    "https://www.linkedhill.com.np/images/property/1660884040table-work-empty-office-room-manager-card-report-pen-48969899.jpg",
  ];

  int _currentPage = 0;
  late PageController _pageController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    ///For auto play
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  ////Manual dot indicator
  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < imageList.length; i++) {
      indicators.add(_buildIndicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: 8.0,
      width: isActive ? 15.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image slider'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ///Image
          PageView.builder(
            controller: _pageController,
            itemCount: imageList.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                imageList[index],
                fit: BoxFit.cover,
              );
            },
          ),

          ///Number and Dot indicator
          Positioned(
            bottom: 20,
            child: Column(
              children: [
                ///Package dot indicator
                SmoothPageIndicator(
                  controller: _pageController,
                  count: imageList.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    type: WormType.normal,
                    activeDotColor: Colors.black,
                    dotColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                //Number indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_currentPage + 1}/${imageList.length}',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                ///Manual Dot Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ],
            ),
          ),

          ///Back button
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
