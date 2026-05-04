import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/models/agent_model.dart';
import 'package:valorant_companion_app/core/models/map_model.dart';
import 'package:valorant_companion_app/core/models/weapon_model.dart';
import 'package:valorant_companion_app/core/providers/api_provider.dart';
import 'package:valorant_companion_app/core/providers/favorites_provider.dart';
import 'package:valorant_companion_app/features/agents/agent_list_screen.dart';
import 'package:valorant_companion_app/features/maps/map_list_screen.dart';
import 'package:valorant_companion_app/features/weapons/weapon_list_screen.dart';

class ExploreSection extends ConsumerWidget {
  const ExploreSection({super.key});

  Widget card(
      BuildContext context,
      String title,
      String subtitle,
      Color color,
      Widget screen,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.3),
              color.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  Widget _favoritesRow<T>({
    required String title,
    required AsyncValue<List<T>> asyncItems,
    required Set<String> favoriteIds,
    required String Function(T item) idBuilder,
    required String Function(T item) nameBuilder,
    required String Function(T item) imageBuilder,
  }) {
    return asyncItems.when(
      loading: () => const SizedBox(
        height: 104,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          'Could not load $title favorites',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      data: (items) {
        final favorites = items
            .where((item) => favoriteIds.contains(idBuilder(item)))
            .toList();

        if (favorites.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 92,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final item = favorites[index];

                  return Container(
                    width: 150,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2A36),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageBuilder(item),
                            height: 52,
                            width: 52,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            nameBuilder(item),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final hasFavorites = favorites.agentIds.isNotEmpty ||
        favorites.weaponIds.isNotEmpty ||
        favorites.mapIds.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("EXPLORE",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white70)),
        const SizedBox(height: 16),

        card(context, "AGENTS", "View all agents", Colors.red,
            const AgentsListScreen()),
        card(context, "GUNS", "View all weapons", Colors.teal,
            const WeaponsListScreen()),
        card(context, "MAPS", "View all maps", Colors.orange,
            const MapsListScreen()),

        const SizedBox(height: 8),
        const Text(
          "FAVORITES",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 12),
        if (!hasFavorites)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2A36),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: const Text(
              "Tap hearts in the lists to save agents, weapons, and maps here.",
              style: TextStyle(color: Colors.white70),
            ),
          )
        else ...[
          _favoritesRow<Agent>(
            title: 'Agents',
            asyncItems: ref.watch(agentsProvider),
            favoriteIds: favorites.agentIds,
            idBuilder: (agent) => agent.uuid,
            nameBuilder: (agent) => agent.displayName,
            imageBuilder: (agent) => agent.displayIcon,
          ),
          _favoritesRow<Weapon>(
            title: 'Weapons',
            asyncItems: ref.watch(weaponsProvider),
            favoriteIds: favorites.weaponIds,
            idBuilder: (weapon) => weapon.uuid,
            nameBuilder: (weapon) => weapon.displayName,
            imageBuilder: (weapon) => weapon.displayIcon,
          ),
          _favoritesRow<ValorantMap>(
            title: 'Maps',
            asyncItems: ref.watch(mapsProvider),
            favoriteIds: favorites.mapIds,
            idBuilder: (map) => map.uuid,
            nameBuilder: (map) => map.displayName,
            imageBuilder: (map) => map.listViewIcon,
          ),
        ],
      ],
    );
  }
}
