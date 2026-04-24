import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:valorant_companion_app/features/agents/agents_screen.dart';
import 'package:valorant_companion_app/features/maps/maps_screen.dart';
import 'package:valorant_companion_app/features/weapons/weapons_screen.dart';
import 'banner_card.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController controller = PageController();
  int index = 0;
  Timer? timer;

  final items = [
    {
      "title": "JETT",
      "subtitle": "The Wind Master",
      "image":
          "https://media.valorant-api.com/agents/9f0d8ba9-4140-b941-57d3-a7ad57c6b417/fullportrait.png"
    },
    {
      "title": "FRENZY",
      "subtitle": "Fast Weapon",
      "image":
          "https://media.valorant-api.com/weapons/44d4e95c-4157-0037-81b2-17841bf2e8e3/displayicon.png"
    },
    {
      "title": "ASCENT",
      "subtitle": "Popular Map",
      "image":
          "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/displayicon.png"
    },
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      index = (index + 1) % items.length;

      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (context, i) {
  final item = items[i];

  if (i == 0) {
    return BannerCard(
      title: item["title"]!,
      subtitle: item["subtitle"]!,
      image: item["image"]!,
      buttonText: "VIEW AGENT",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AgentsScreen()),
        );
      },
    );
  } else if (i == 1) {
    return BannerCard(
      title: item["title"]!,
      subtitle: item["subtitle"]!,
      image: item["image"]!,
      buttonText: "VIEW GUNS",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WeaponsScreen()),
        );
      },
    );
  } else {
    return BannerCard(
      title: item["title"]!,
      subtitle: item["subtitle"]!,
      image: item["image"]!,
      buttonText: "VIEW MAPS",
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MapsScreen()),
        );
      },
    );
  }
},
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: controller,
          count: items.length,
          effect: const WormEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.white,
          ),
        ),
      ],
    );
  }
}