import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/providers/favorites_provider.dart';
import 'package:valorant_companion_app/core/widgets/list_item_card.dart';
import '../../core/providers/api_provider.dart';

class AgentsListScreen extends ConsumerWidget {
  const AgentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentsAsync = ref.watch(agentsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Agents")),
      body: agentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (agents) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: agents.length,
            itemBuilder: (_, i) {
              final item = agents[i];

              return ListItemCard(
                name: item.displayName,
                image: item.displayIcon,
                isFavorite: favorites.isFavorite(FavoriteType.agent, item.uuid),
                onFavoritePressed: () => ref
                    .read(favoritesProvider.notifier)
                    .toggleFavorite(FavoriteType.agent, item.uuid),
              );
            },
          );
        },
      ),
    );
  }
}
