import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/api_provider.dart';
import '../../core/providers/agent_provider.dart';

class AgentDetailScreen extends ConsumerWidget {
  const AgentDetailScreen({super.key});

  Color _parseApiHex(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 8) {
      
      String alpha = hex.substring(6, 8);
      String rgb = hex.substring(0, 6);
      hex = alpha + rgb;
    } else if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentsAsync = ref.watch(agentsProvider);
    final selectedAgent = ref.watch(selectedAgentProvider);

    return Scaffold(
      body: agentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (agents) {
          if (agents.isEmpty) return const Center(child: Text("No Agents"));

          final agent = selectedAgent ?? agents.first;

          final List<dynamic> apiGradients =
              agent["backgroundGradientColors"] ?? [];
          final String? bgImageUrl = agent["background"];
          final String? portraitUrl = agent["fullPortrait"];

          final List<Color> themeColors = apiGradients.isNotEmpty
              ? apiGradients.map((c) => _parseApiHex(c.toString())).toList()
              : [const Color(0xFF0F1923), const Color(0xFF0F1923)];

          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: themeColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              if (bgImageUrl != null)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.3, // Keeps the gradient dominant
                    child: Image.network(bgImageUrl, fit: BoxFit.cover),
                  ),
                ),

              Positioned(
                bottom: 0,
                left: -50,
                right: -50,
                child: portraitUrl != null
                    ? Image.network(
                        portraitUrl,
                        height: MediaQuery.of(context).size.height * 0.8,
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(),
              ),

              Positioned(
                top: 60,
                left: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent["displayName"]?.toUpperCase() ?? "",
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      agent["role"]?["displayName"]?.toUpperCase() ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
              ),

              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: agents.length,
                    itemBuilder: (context, index) {
                      final item = agents[index];
                      final isSelected = item["uuid"] == agent["uuid"];

                      return GestureDetector(
                        onTap: () =>
                            ref.read(selectedAgentProvider.notifier).state =
                                item,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 80,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                              isSelected ? 0.6 : 0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Image.network(item["displayIcon"] ?? ""),
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
