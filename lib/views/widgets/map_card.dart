import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  final String eventTitle;

  final String currentMapName;
  final String currentMapImage;
  final String currentRemainingTimer;
  final String currentStartTime;
  final String currentEndTime;

  final String nextMapName;
  final String nextMapImage;
  final String nextStartTime;
  final String nextEndTime;

  const MapCard({
    super.key,
    required this.eventTitle,

    required this.currentMapName,
    required this.currentMapImage,
    required this.currentRemainingTimer,
    required this.currentStartTime,
    required this.currentEndTime,

    required this.nextMapName,
    required this.nextMapImage,
    required this.nextStartTime,
    required this.nextEndTime,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? tryParseIso(String s) {
      try {
        return DateTime.parse(s);
      } catch (_) {
        return null;
      }
    }

    String formatTimeFromIso(String s, {int offsetHours = 3}) {
      final dt = tryParseIso(s);
      if (dt == null) return '--:--';

      final adjusted = dt.add(Duration(hours: offsetHours));

      final time = TimeOfDay.fromDateTime(adjusted);

      final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minute = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';

      return '$hour:$minute $period';
    }

    final String currentStart = formatTimeFromIso(currentStartTime);
    final String currentEnd = formatTimeFromIso(currentEndTime);

    final String nextStart = formatTimeFromIso(nextStartTime);
    final String nextEnd = formatTimeFromIso(nextEndTime);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      width: MediaQuery.sizeOf(context).width,
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // event title
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(
                  eventTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // current map image
                  Image.network(currentMapImage, fit: BoxFit.cover),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Column(
                              children: [
                                // current map name
                                Text(
                                  currentMapName,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                  ),
                                ),

                                // current from - to
                                Text(
                                  "From $currentStart to $currentEnd",
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 20),

                        // current remaining time
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            currentRemainingTimer,
                            maxLines: 1,
                            softWrap: false,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // next
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white, width: 2.5),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // next map image
                  Image.network(nextMapImage, fit: BoxFit.cover),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // next
                        Text(
                          "NEXT :",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(width: 10),

                        // next map name
                        Text(
                          nextMapName.length >= 11
                              ? "${nextMapName.substring(0, 11)}..."
                              : nextMapName,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(width: 10),

                        // next from - to
                        Text(
                          "From $nextStart to $nextEnd",
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
