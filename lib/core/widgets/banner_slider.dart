import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> banners = [
    {
      "title": "JETT",
      "subtitle": "The Wind Master",
      "image": "https://media.valorant-api.com/agents/9f0d8ba9-4140-b941-57d3-a7ad57c6b417/fullportrait.png"
    },
    {
      "title": "SAGE",
      "subtitle": "The Healer",
      "image": "https://media.valorant-api.com/agents/569fdd95-4d10-43ab-ca70-79becc718b46/fullportrait.png"
    },
    {
      "title": "PHOENIX",
      "subtitle": "Fire Duelist",
      "image": "https://media.valorant-api.com/agents/eb93336a-449b-9c1b-0a54-a891f7921d69/fullportrait.png"
    },
  ];

  @override
  void initState() {
    super.initState();

    // AUTO SCROLL
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            onPageChanged: (index) {
              _currentPage = index;
            },
            itemBuilder: (context, index) {
              final item = banners[index];

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1F2A36), Color(0xFF0F1923)],
                  ),
                ),
                child: Stack(
                  children: [
                    // IMAGE
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.network(
                        item["image"]!,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // TEXT
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["title"]!,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            item["subtitle"]!,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {},
                            child: const Text("VIEW AGENT"),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // INDICATOR
        SmoothPageIndicator(
          controller: _controller,
          count: banners.length,
          effect: const WormEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.red,
          ),
        ),
      ],
    );
  }
}