import 'package:flutter/material.dart';
import 'package:valorant_companion_app/core/models/agent_model.dart';
import 'package:valorant_companion_app/core/providers/api_provider.dart';
import 'package:valorant_companion_app/features/home/list_screen.dart';

class AgentsScreen extends StatelessWidget {
  const AgentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreen<Agent>(
      title: "Agents",
      provider: agentsProvider,
      nameBuilder: (agent) => agent.displayName,
      imageBuilder: (agent) => agent.displayIcon,
    );
  }
}
