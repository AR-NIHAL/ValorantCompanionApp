import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/providers/agent_provider.dart';
import '../../core/providers/api_provider.dart';


class MapDetailScreen extends ConsumerWidget {
  const MapDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapsAsync = ref.watch(mapsProvider);
    final selected = ref.watch(selectedMapProvider);

    return Scaffold(
      body: mapsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (maps) {
          if (maps.isEmpty) return const Center(child: Text("No Maps"));

          if (selected == null && maps.isNotEmpty) {
            Future.microtask(() {
              ref.read(selectedMapProvider.notifier).state = maps[0];
            });
          }

          final map = selected ?? maps[0];

          return Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  map.displayIcon,
                  fit: BoxFit.contain,
                ),
              ),

              Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),

              Positioned(
                top: 80,
                left: 20,
                child: Text(
                  map.displayName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: maps.length,
                    itemBuilder: (_, i) {
                      final item = maps[i];
                      final isSelected = item.uuid == map.uuid;

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedMapProvider.notifier)
                              .state = item;
                        },
                        child: Container(
                          width: 90,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.orange
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  item.listViewIcon,
                                ),
                              ),
                              Text(
                                item.displayName,
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
