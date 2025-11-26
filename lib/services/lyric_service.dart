import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class LyricService {
  static const String _geniusAccessToken =
      'ulDsEGwJnJCR-ovYsXKzRCgYkcqWIzbFvMHcutDRrykIKbyFDN9g0yzBl8QpUtJA';

  static Future<String> getLyrics(String artist, String title) async {
    print("🎵 Searching for lyrics: $artist - $title");

    String lyrics = await _tryGeniusAPI(artist, title);
    if (_isValidLyrics(lyrics)) return lyrics;

    lyrics = await _tryLyricsOVH(artist, title);
    if (_isValidLyrics(lyrics)) return lyrics;

    return _mockLyrics(artist, title);
  }

  static Future<String> _tryGeniusAPI(String artist, String title) async {
    if (_geniusAccessToken.isEmpty) return 'Genius token not configured';

    try {
      final searchUrl =
          'https://api.genius.com/search?q=${Uri.encodeComponent("$artist $title")}';

      final response = await http.get(
        Uri.parse(searchUrl),
        headers: {
          'Authorization': 'Bearer $_geniusAccessToken',
          'User-Agent': 'SoundScribe/1.0',
        },
      );

      print("🔍 Genius Search: ${response.statusCode}");

      if (response.statusCode != 200) {
        return "Genius API error: ${response.statusCode}";
      }

      final jsonData = json.decode(response.body);
      final hits = jsonData['response']['hits'];

      if (hits == null || hits.isEmpty) return "Song not found on Genius";

      final song = hits[0]['result'];
      final url = song['url'];

      return await _scrapeGeniusLyrics(url);
    } catch (e) {
      return "Genius search error: $e";
    }
  }

  static Future<String> _scrapeGeniusLyrics(String url) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'User-Agent': 'Mozilla/5.0 (Flutter-Lyrics-App)'},
      );

      if (response.statusCode != 200) {
        return "Genius page error: ${response.statusCode}";
      }

      final document = html_parser.parse(response.body);

      // Genius stores lyrics inside <div data-lyrics-container="true">
      final containers = document.querySelectorAll(
        '[data-lyrics-container="true"]',
      );

      if (containers.isEmpty) return "Lyrics not found on Genius page";

      String lyrics = containers.map((c) => c.text.trim()).join("\n\n");

      // Clean formatting
      lyrics = _formatLyrics(lyrics);

      return lyrics;
    } catch (e) {
      return "Scraping failed: $e";
    }
  }

  static Future<String> _tryLyricsOVH(String artist, String title) async {
    try {
      final url =
          'https://api.lyrics.ovh/v1/${Uri.encodeComponent(artist)}/${Uri.encodeComponent(title)}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) return '';

      final data = json.decode(response.body);
      return data['lyrics'] ?? '';
    } catch (_) {
      return '';
    }
  }

  static bool _isValidLyrics(String lyrics) {
    if (lyrics.isEmpty) return false;
    if (lyrics.length < 50) return false;

    final badWords = ['error', 'not found', 'failed', 'token', 'invalid'];
    for (final w in badWords) {
      if (lyrics.toLowerCase().contains(w)) return false;
    }
    return true;
  }

  static String _formatLyrics(String text) {
    return text
        // Keep section headers like [Verse 1], [Chorus]
        .replaceAllMapped(RegExp(r'\[(.*?)\]'), (m) => '\n\n[${m[1]}]\n')
        // Fix multiple newlines
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  static String _mockLyrics(String artist, String title) {
    return '''
"$title" by $artist

Lyrics unavailable from online providers.

Possible reasons:
• Song is not indexed by Genius
• Lyrics API limitations
• Internet connection issues

Try a different title or check your API token.
''';
  }
}
