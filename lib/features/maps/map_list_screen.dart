import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/providers/api_provider.dart';
import 'package:valorant_companion_app/core/widgets/list_item_card.dart';

class MapsListScreen extends ConsumerWidget {
  const MapsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapsAsync = ref.watch(mapsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Maps")),
      body: mapsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (maps) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: maps.length,
            itemBuilder: (_, i) {
              final item = maps[i];

              return ListItemCard(
                name: item["displayName"] ?? "",
                image: item["displayIcon"] ?? "",
              );
            },
          );
        },
      ),
    );
  }
}