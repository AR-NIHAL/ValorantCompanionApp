import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:valorant_companion_app/core/models/agent_model.dart';
import 'package:valorant_companion_app/core/models/map_model.dart';
import 'package:valorant_companion_app/core/models/weapon_model.dart';

class ApiService {
  final base = "https://valorant-api.com/v1";

  Future<List<Agent>> getAgents() async {
    final res = await http.get(Uri.parse("$base/agents"));
    final data = jsonDecode(res.body)["data"] as List<dynamic>;
    return data
        .map((item) => Agent.fromJson(item as Map<String, dynamic>))
        .where((agent) =>
            agent.displayName.isNotEmpty && agent.displayIcon.isNotEmpty)
        .toList();
  }

  Future<List<Weapon>> getWeapons() async {
    final res = await http.get(Uri.parse("$base/weapons"));
    final data = jsonDecode(res.body)["data"] as List<dynamic>;
    return data
        .map((item) => Weapon.fromJson(item as Map<String, dynamic>))
        .where((weapon) =>
            weapon.displayName.isNotEmpty && weapon.displayIcon.isNotEmpty)
        .toList();
  }

  Future<List<ValorantMap>> getMaps() async {
    final res = await http.get(Uri.parse("$base/maps"));
    final data = jsonDecode(res.body)["data"] as List<dynamic>;
    return data
        .map((item) => ValorantMap.fromJson(item as Map<String, dynamic>))
        .where((map) =>
            map.displayName.isNotEmpty &&
            map.displayIcon.isNotEmpty &&
            map.listViewIcon.isNotEmpty)
        .toList();
  }
}
