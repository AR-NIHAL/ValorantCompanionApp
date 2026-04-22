import 'package:flutter/material.dart';
import 'package:valorant_companion_app/core/widgets/banner_slider.dart';
import '../../core/widgets/category_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VALORANT GUIDE"),
      ),

      // ✅ FIXED BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 Banner Slider
              const BannerSlider(),

              const SizedBox(height: 24),

              // 🔤 Explore Title
              const Text(
                "EXPLORE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 16),

              // 🟥 Agents Card
              CategoryCard(
  title: "AGENTS",
  subtitle: "View all agents",
  color: Colors.red,
  onTap: () {},
),

// 🟩 GUNS (VANDAL)
CategoryCard(
  title: "GUNS",
  subtitle: "Vandal",
  color: Colors.green,
  imageUrl:
      "https://media.valorant-api.com/weapons/9c82e19d-4575-0200-1a81-3eacf00cf872/displayicon.png",
  onTap: () {},
),

// 🟧 MAPS (ASCENT)
CategoryCard(
  title: "MAPS",
  subtitle: "Ascent",
  color: Colors.orange,
  imageUrl:
      "https://media.valorant-api.com/maps/7eaecc1b-4337-bbf6-6ab9-04b8f06b3319/displayicon.png",
  onTap: () {},
),
            ],
          ),
        ),
      ),
    );
  }
}