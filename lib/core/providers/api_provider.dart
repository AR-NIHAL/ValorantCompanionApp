import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/api_service.dart';

// 🔥 THIS WAS MISSING
final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// ✅ Typed providers
final agentsProvider = FutureProvider<List<dynamic>>((ref) async {
  return await ref.read(apiProvider).getAgents();
});

final weaponsProvider = FutureProvider<List<dynamic>>((ref) async {
  return await ref.read(apiProvider).getWeapons();
});

final mapsProvider = FutureProvider<List<dynamic>>((ref) async {
  return await ref.read(apiProvider).getMaps();
});