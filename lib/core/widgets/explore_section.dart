import 'package:flutter/material.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  Widget card(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.7)],
        ),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: Colors.white70)),
          ]),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("EXPLORE",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white70)),
        const SizedBox(height: 16),

        card("AGENTS", "View all agents", Colors.red),
        card("GUNS", "View all weapons", Colors.teal),
        card("MAPS", "View all maps", Colors.orange),
      ],
    );
  }
}