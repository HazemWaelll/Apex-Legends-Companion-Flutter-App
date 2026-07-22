class MapEvent {
  final String map;
  final String asset;
  final String remainingTimer;
  final int remainingSecs;
  final String startTime;
  final String endTime;

  MapEvent({
    required this.map,
    required this.asset,
    required this.remainingTimer,
    required this.remainingSecs,
    required this.startTime,
    required this.endTime,
  });

  factory MapEvent.fromJson(Map<String, dynamic> json) {
    return MapEvent(
      map: json['map'] as String? ?? '',
      asset: json['asset'] as String? ?? '',
      remainingTimer: json['remainingTimer'] as String? ?? '',
      remainingSecs: json['remainingSecs'] as int? ?? 0,
      startTime: json['readableDate_start'] as String? ?? '',
      endTime: json['readableDate_end'] as String? ?? '',
    );
  }
}

class MapSection {
  final MapEvent current;
  final MapEvent next;

  MapSection({required this.current, required this.next});

  factory MapSection.fromJson(Map<String, dynamic> json) {
    return MapSection(
      current: MapEvent.fromJson(
        json['current'] as Map<String, dynamic>? ?? {},
      ),
      next: MapEvent.fromJson(json['next'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class ModeType {
  final MapSection battleRoyale;
  final MapSection ranked;
  final MapSection ltm;
  final MapSection wildcard;

  ModeType({
    required this.battleRoyale,
    required this.ranked,
    required this.ltm,
    required this.wildcard,
  });

  factory ModeType.fromJson(Map<String, dynamic> json) {
    return ModeType(
      battleRoyale: MapSection.fromJson(
        json['battle_royale'] as Map<String, dynamic>? ?? {},
      ),
      ranked: MapSection.fromJson(
        json['ranked'] as Map<String, dynamic>? ?? {},
      ),
      ltm: MapSection.fromJson(json['ltm'] as Map<String, dynamic>? ?? {}),
      wildcard: MapSection.fromJson(
        json['wildcard'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  static ModeType mapsFromSnapshot(Map<String, dynamic> json) {
    return ModeType.fromJson(json);
  }
}
