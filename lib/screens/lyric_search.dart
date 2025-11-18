import 'package:flutter/material.dart';
import 'package:soundscribe_fl/services/lyric_service.dart';

// ignore: use_key_in_widget_constructors
class LyricsSearch extends StatefulWidget {
  @override
  _LyricsSearchState createState() => _LyricsSearchState();
}

class _LyricsSearchState extends State<LyricsSearch> {
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  String _lyrics = '';
  bool _isLoading = false;

  void _searchLyrics() async {
    if (_artistController.text.isEmpty || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both artist and song title')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _lyrics = '';
    });

    final lyrics = await LyricService.getLyrics(
      _artistController.text.trim(),
      _titleController.text.trim(),
    );

    setState(() {
      _lyrics = lyrics;
      _isLoading = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _artistController.clear();
      _titleController.clear();
      _lyrics = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lyrics Search'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearSearch,
            tooltip: 'Clear Search',
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Form
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _artistController,
                      decoration: InputDecoration(
                        labelText: 'Artist',
                        hintText: 'e.g., Taylor Swift',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Song Title',
                        hintText: 'e.g., Shake It Off',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.music_note),
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _searchLyrics,
                        child: _isLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text('Search Lyrics'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Results
            Expanded(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Searching for lyrics...'),
          ],
        ),
      );
    }

    if (_lyrics.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'Enter artist and song title to find lyrics',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Song Info
              if (_lyrics != 'Lyrics not found for this song' &&
                  _lyrics != 'Error: Failed to load lyrics (404)' &&
                  !_lyrics.startsWith('Error:'))
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${_titleController.text} by ${_artistController.text}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),

              // Lyrics
              SelectableText(
                _lyrics,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
