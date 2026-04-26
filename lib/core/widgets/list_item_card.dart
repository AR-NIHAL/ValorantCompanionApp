import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  final String name;
  final String image;

  const ListItemCard({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2A36),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // IMAGE LEFT
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // NAME RIGHT
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}