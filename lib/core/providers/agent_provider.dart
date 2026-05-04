import 'package:flutter_riverpod/legacy.dart';
import 'package:valorant_companion_app/core/models/agent_model.dart';
import 'package:valorant_companion_app/core/models/map_model.dart';
import 'package:valorant_companion_app/core/models/weapon_model.dart';

final selectedAgentProvider = StateProvider<Agent?>((ref) {
  return null;
});

final selectedWeaponProvider = StateProvider<Weapon?>((ref) => null);

final selectedMapProvider = StateProvider<ValorantMap?>((ref) => null);
