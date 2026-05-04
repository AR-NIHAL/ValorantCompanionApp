import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/models/agent_model.dart';
import 'package:valorant_companion_app/core/models/map_model.dart';
import 'package:valorant_companion_app/core/models/weapon_model.dart';
import 'package:valorant_companion_app/core/providers/api_provider.dart';
import 'package:valorant_companion_app/core/providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final hasFavorites = favorites.agentIds.isNotEmpty ||
        favorites.weaponIds.isNotEmpty ||
        favorites.mapIds.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite,
              color: Color(0xFFFF4655),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: hasFavorites
            ? ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _FavoritesGridSection<Agent>(
                    title: 'Agents',
                    asyncItems: ref.watch(agentsProvider),
                    favoriteIds: favorites.agentIds,
                    type: FavoriteType.agent,
                    idBuilder: (agent) => agent.uuid,
                    nameBuilder: (agent) => agent.displayName,
                    imageBuilder: (agent) => agent.displayIcon,
                  ),
                  _FavoritesGridSection<Weapon>(
                    title: 'Weapons',
                    asyncItems: ref.watch(weaponsProvider),
                    favoriteIds: favorites.weaponIds,
                    type: FavoriteType.weapon,
                    idBuilder: (weapon) => weapon.uuid,
                    nameBuilder: (weapon) => weapon.displayName,
                    imageBuilder: (weapon) => weapon.displayIcon,
                  ),
                  _FavoritesGridSection<ValorantMap>(
                    title: 'Maps',
                    asyncItems: ref.watch(mapsProvider),
                    favoriteIds: favorites.mapIds,
                    type: FavoriteType.map,
                    idBuilder: (map) => map.uuid,
                    nameBuilder: (map) => map.displayName,
                    imageBuilder: (map) => map.listViewIcon,
                  ),
                ],
              )
            : const _EmptyFavoritesState(),
      ),
    );
  }
}

class _FavoritesGridSection<T> extends ConsumerWidget {
  final String title;
  final AsyncValue<List<T>> asyncItems;
  final Set<String> favoriteIds;
  final FavoriteType type;
  final String Function(T item) idBuilder;
  final String Function(T item) nameBuilder;
  final String Function(T item) imageBuilder;

  const _FavoritesGridSection({
    required this.title,
    required this.asyncItems,
    required this.favoriteIds,
    required this.type,
    required this.idBuilder,
    required this.nameBuilder,
    required this.imageBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (favoriteIds.isEmpty) return const SizedBox.shrink();

    return asyncItems.when(
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Text(
          'Could not load $title favorites',
          style: const TextStyle(color: Colors.white70),
        ),
      ),
      data: (items) {
        final sectionItems = items
            .where((item) => favoriteIds.contains(idBuilder(item)))
            .toList();

        if (sectionItems.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sectionItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (_, index) {
                  final item = sectionItems[index];

                  return _FavoriteGridCard(
                    name: nameBuilder(item),
                    image: imageBuilder(item),
                    onRemove: () => ref
                        .read(favoritesProvider.notifier)
                        .toggleFavorite(type, idBuilder(item)),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FavoriteGridCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onRemove;

  const _FavoriteGridCard({
    required this.name,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF1F2A36).withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFF4655).withValues(alpha: 0.42)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF4655).withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Color(0xFF1F2A36),
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.76),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton.filled(
              tooltip: 'Remove favorite',
              style: IconButton.styleFrom(
                backgroundColor: Colors.black.withValues(alpha: 0.48),
                foregroundColor: const Color(0xFFFF4655),
              ),
              onPressed: onRemove,
              icon: const Icon(Icons.favorite),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Text(
              name.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyFavoritesState extends StatelessWidget {
  const _EmptyFavoritesState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2A36).withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFFF4655).withValues(alpha: 0.32),
            ),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.favorite_border,
                size: 42,
                color: Color(0xFFFF4655),
              ),
              SizedBox(height: 14),
              Text(
                'No favorites yet!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Tap the heart on agents, weapons, or maps to build your quick-access collection.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
