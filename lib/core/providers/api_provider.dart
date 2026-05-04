import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_service.dart';
import '../models/agent_model.dart';
import '../models/map_model.dart';
import '../models/weapon_model.dart';

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final agentsProvider = FutureProvider<List<Agent>>((ref) async {
  return await ref.read(apiProvider).getAgents();
});

final weaponsProvider = FutureProvider<List<Weapon>>((ref) async {
  return await ref.read(apiProvider).getWeapons();
});

final mapsProvider = FutureProvider<List<ValorantMap>>((ref) async {
  return await ref.read(apiProvider).getMaps();
});
