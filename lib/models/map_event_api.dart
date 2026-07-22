import 'dart:convert';
import 'package:apex_companion/models/map_event.dart';
import 'package:http/http.dart' as http;

class MapEventApi {
  static Future<ModeType> getMaps() async {
    final uri = Uri.parse(
      'https://api.apexlegendsstatus.com/maprotation?auth=91d6ef862509cb89302b3a9a9003a2fb&version=2',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load map rotation');
    }

    final Map<String, dynamic> jsonData = jsonDecode(response.body);

    return ModeType.mapsFromSnapshot(jsonData);
  }
}
