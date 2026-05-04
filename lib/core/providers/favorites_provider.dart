import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum FavoriteType {
  agent,
  weapon,
  map,
}

class FavoritesState {
  final Set<String> agentIds;
  final Set<String> weaponIds;
  final Set<String> mapIds;

  const FavoritesState({
    this.agentIds = const {},
    this.weaponIds = const {},
    this.mapIds = const {},
  });

  FavoritesState copyWith({
    Set<String>? agentIds,
    Set<String>? weaponIds,
    Set<String>? mapIds,
  }) {
    return FavoritesState(
      agentIds: agentIds ?? this.agentIds,
      weaponIds: weaponIds ?? this.weaponIds,
      mapIds: mapIds ?? this.mapIds,
    );
  }

  bool isFavorite(FavoriteType type, String id) {
    return switch (type) {
      FavoriteType.agent => agentIds.contains(id),
      FavoriteType.weapon => weaponIds.contains(id),
      FavoriteType.map => mapIds.contains(id),
    };
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, FavoritesState>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<FavoritesState> {
  static const _agentKey = 'favorite_agent_ids';
  static const _weaponKey = 'favorite_weapon_ids';
  static const _mapKey = 'favorite_map_ids';

  @override
  FavoritesState build() {
    unawaited(_loadFavorites());
    return const FavoritesState();
  }

  Future<void> toggleFavorite(FavoriteType type, String id) async {
    if (id.isEmpty) return;

    state = switch (type) {
      FavoriteType.agent => state.copyWith(
          agentIds: _toggleId(state.agentIds, id),
        ),
      FavoriteType.weapon => state.copyWith(
          weaponIds: _toggleId(state.weaponIds, id),
        ),
      FavoriteType.map => state.copyWith(
          mapIds: _toggleId(state.mapIds, id),
        ),
    };

    await _saveFavorites();
  }

  Set<String> _toggleId(Set<String> currentIds, String id) {
    final nextIds = {...currentIds};
    if (nextIds.contains(id)) {
      nextIds.remove(id);
    } else {
      nextIds.add(id);
    }
    return nextIds;
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    state = FavoritesState(
      agentIds: prefs.getStringList(_agentKey)?.toSet() ?? {},
      weaponIds: prefs.getStringList(_weaponKey)?.toSet() ?? {},
      mapIds: prefs.getStringList(_mapKey)?.toSet() ?? {},
    );
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setStringList(_agentKey, state.agentIds.toList()),
      prefs.setStringList(_weaponKey, state.weaponIds.toList()),
      prefs.setStringList(_mapKey, state.mapIds.toList()),
    ]);
  }
}
