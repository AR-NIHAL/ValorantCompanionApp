import 'package:flutter/material.dart';
import 'package:valorant_companion_app/features/favorites/favorites_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT TEXT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "VALORANT",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF4655),
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                "GUIDE",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),

          IconButton(
            tooltip: 'Favorites',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
            icon: const Icon(
              Icons.favorite_border,
              color: Color(0xFFFF4655),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
