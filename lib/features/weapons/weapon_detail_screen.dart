import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valorant_companion_app/core/providers/agent_provider.dart';
import '../../core/providers/api_provider.dart';

class WeaponDetailScreen extends ConsumerWidget {
  const WeaponDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weaponsAsync = ref.watch(weaponsProvider);
    final selected = ref.watch(selectedWeaponProvider);

    return Scaffold(
      body: weaponsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (weapons) {
          if (weapons.isEmpty) return const Center(child: Text("No Weapons"));

          if (selected == null && weapons.isNotEmpty) {
            Future.microtask(() {
              ref.read(selectedWeaponProvider.notifier).state = weapons[0];
            });
          }

          final weapon = selected ?? weapons[0];

          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F1923), Color(0xFF1F2A36)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              Center(
                child: Image.network(
                  weapon.displayIcon,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

              Positioned(
                top: 80,
                left: 20,
                child: Text(
                  weapon.displayName,
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
                    itemCount: weapons.length,
                    itemBuilder: (_, i) {
                      final item = weapons[i];
                      final isSelected = item.uuid == weapon.uuid;

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedWeaponProvider.notifier)
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
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Image.network(
                                  item.displayIcon,
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
