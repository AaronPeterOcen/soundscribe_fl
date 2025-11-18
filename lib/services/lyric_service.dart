import 'dart:convert';
import 'package:http/http.dart' as http;

class LyricService {
  static const String _baseUrl = 'https://api.lyrics.ovh/v1';

  // Search for lyrics by artist and title
  static Future<String> getLyrics(String artist, String title) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/${Uri.encodeComponent(artist)}/${Uri.encodeComponent(title)}',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['lyrics'] ?? 'No lyrics found';
      } else if (response.statusCode == 404) {
        return 'Lyrics not found for this song';
      } else {
        return 'Error: Failed to load lyrics (${response.statusCode})';
      }
    } catch (e) {
      return 'Error: Could not connect to lyrics service';
    }
  }
}
