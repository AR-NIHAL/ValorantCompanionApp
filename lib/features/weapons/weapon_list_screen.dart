import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/providers/api_provider.dart';
import 'package:valorant_companion_app/core/widgets/list_item_card.dart';

class WeaponsListScreen extends ConsumerWidget {
  const WeaponsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weaponsAsync = ref.watch(weaponsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Weapons")),
      body: weaponsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (weapons) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: weapons.length,
            itemBuilder: (_, i) {
              final item = weapons[i];

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