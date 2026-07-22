import 'package:apex_companion/models/map_event_api.dart';
import 'package:apex_companion/models/map_event.dart';
import 'package:apex_companion/views/widgets/map_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ModeType? _rotation;
  bool _isLoading = true;
  bool _isFetching = false;
  bool _refreshScheduled = false;
  Timer? _refreshTimer;

  int _battleRoyaleRemainingSecs = 0;
  int _rankedRemainingSecs = 0;
  int _ltmRemainingSecs = 0;
  int _wildcardRemainingSecs = 0;

  @override
  void initState() {
    super.initState();
    _loadMaps();
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickCountdown();
    });
  }

  void _tickCountdown() {
    if (!mounted || _rotation == null || _isFetching) {
      return;
    }

    if (_refreshScheduled) {
      return;
    }

    var shouldRefresh = false;

    setState(() {
      if (_battleRoyaleRemainingSecs > 0) {
        _battleRoyaleRemainingSecs--;
      }
      if (_rankedRemainingSecs > 0) {
        _rankedRemainingSecs--;
      }
      if (_ltmRemainingSecs > 0) {
        _ltmRemainingSecs--;
      }
      if (_wildcardRemainingSecs > 0) {
        _wildcardRemainingSecs--;
      }

      shouldRefresh =
          _battleRoyaleRemainingSecs == 0 ||
          _rankedRemainingSecs == 0 ||
          _ltmRemainingSecs == 0 ||
          _wildcardRemainingSecs == 0;

      if (shouldRefresh) {
        _refreshScheduled = true;
      }
    });

    if (shouldRefresh) {
      _loadMaps();
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadMaps() async {
    if (_isFetching) {
      return;
    }

    _isFetching = true;

    try {
      final rotation = await MapEventApi.getMaps();
      if (!mounted) {
        return;
      }

      setState(() {
        _rotation = rotation;
        _battleRoyaleRemainingSecs =
            rotation.battleRoyale.current.remainingSecs;
        _rankedRemainingSecs = rotation.ranked.current.remainingSecs;
        _ltmRemainingSecs = rotation.ltm.current.remainingSecs;
        _wildcardRemainingSecs = rotation.wildcard.current.remainingSecs;
        _isLoading = false;
        _refreshScheduled = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      if (_rotation != null) {
        setState(() {
          _refreshScheduled = false;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: (_isLoading || _rotation == null)
          ? Center(child: const CircularProgressIndicator(color: Colors.red))
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // BR Pubs
                    MapCard(
                      eventTitle: "BR Pubs",

                      // current
                      currentMapName: _rotation!.battleRoyale.current.map,
                      currentMapImage: _rotation!.battleRoyale.current.asset,
                      currentRemainingTimer: _formatRemainingTime(
                        _battleRoyaleRemainingSecs,
                      ),
                      currentStartTime:
                          _rotation!.battleRoyale.current.startTime,
                      currentEndTime: _rotation!.battleRoyale.current.endTime,

                      // next
                      nextMapName: _rotation!.battleRoyale.next.map,
                      nextMapImage: _rotation!.battleRoyale.next.asset,
                      nextStartTime: _rotation!.battleRoyale.next.startTime,
                      nextEndTime: _rotation!.battleRoyale.next.endTime,
                    ),

                    // BR Ranked
                    MapCard(
                      eventTitle: "BR Ranked",

                      // current
                      currentMapName: _rotation!.ranked.current.map,
                      currentMapImage: _rotation!.ranked.current.asset,
                      currentRemainingTimer: _formatRemainingTime(
                        _rankedRemainingSecs,
                      ),
                      currentStartTime: _rotation!.ranked.current.startTime,
                      currentEndTime: _rotation!.ranked.current.endTime,

                      // next
                      nextMapName: _rotation!.ranked.next.map,
                      nextMapImage: _rotation!.ranked.next.asset,
                      nextStartTime: _rotation!.ranked.next.startTime,
                      nextEndTime: _rotation!.ranked.next.endTime,
                    ),

                    // ltm
                    MapCard(
                      eventTitle: "Mixtape",

                      // current
                      currentMapName: _rotation!.ltm.current.map,
                      currentMapImage: _rotation!.ltm.current.asset,
                      currentRemainingTimer: _formatRemainingTime(
                        _ltmRemainingSecs,
                      ),
                      currentStartTime: _rotation!.ltm.current.startTime,
                      currentEndTime: _rotation!.ltm.current.endTime,

                      // next
                      nextMapName: _rotation!.ltm.next.map,
                      nextMapImage: _rotation!.ltm.next.asset,
                      nextStartTime: _rotation!.ltm.next.startTime,
                      nextEndTime: _rotation!.ltm.next.endTime,
                    ),

                    // wildcard
                    MapCard(
                      eventTitle: "Wildcard",

                      // current
                      currentMapName: _rotation!.wildcard.current.map,
                      currentMapImage: _rotation!.wildcard.current.asset,
                      currentRemainingTimer: _formatRemainingTime(
                        _wildcardRemainingSecs,
                      ),
                      currentStartTime: _rotation!.wildcard.current.startTime,
                      currentEndTime: _rotation!.wildcard.current.endTime,

                      // next
                      nextMapName: _rotation!.wildcard.next.map,
                      nextMapImage: _rotation!.wildcard.next.asset,
                      nextStartTime: _rotation!.wildcard.next.startTime,
                      nextEndTime: _rotation!.wildcard.next.endTime,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  String _formatRemainingTime(int totalSeconds) {
    final safeSeconds = totalSeconds < 0 ? 0 : totalSeconds;
    final hours = safeSeconds ~/ 3600;
    final minutes = (safeSeconds % 3600) ~/ 60;
    final seconds = safeSeconds % 60;

    if (hours > 0) {
      return '${hours}h ${minutes.toString().padLeft(2, '0')}m';
    }

    return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
  }
}
