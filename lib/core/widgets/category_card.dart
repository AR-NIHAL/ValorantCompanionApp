import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final String? imageUrl; // 🔥 new

  const CategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.4),
              color.withOpacity(0.8),
            ],
          ),
        ),
        child: Row(
          children: [
            // 🔥 IMAGE
            if (imageUrl != null)
              Container(
                height: 60,
                width: 60,
                margin: const EdgeInsets.only(right: 16),
                child: Image.network(imageUrl!, fit: BoxFit.contain),
              ),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, color: Colors.white),
          ],
        ),
      ),
    );
  }
}