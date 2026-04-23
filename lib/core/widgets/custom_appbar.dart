import 'package:flutter/material.dart';

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

          // RIGHT ICON
          Stack(
            children: [
              const Icon(Icons.notifications_none, size: 28),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}