import 'package:flutter/material.dart';

class ListItemCard extends StatelessWidget {
  final String name;
  final String image;
  final bool isFavorite;
  final VoidCallback? onFavoritePressed;

  const ListItemCard({
    super.key,
    required this.name,
    required this.image,
    this.isFavorite = false,
    this.onFavoritePressed,
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

          if (onFavoritePressed != null)
            IconButton(
              tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
              onPressed: onFavoritePressed,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? const Color(0xFFFF4655) : Colors.white70,
              ),
            ),
        ],
      ),
    );
  }
}
