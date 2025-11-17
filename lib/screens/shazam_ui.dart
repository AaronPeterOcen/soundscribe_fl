import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShazamUi extends StatefulWidget {
  @override
  _ShazamUiState createState() => _ShazamUiState();
}

class _ShazamUiState extends State<ShazamUi> {
  bool _isListening = false;
  String _currentSong = 'Tap to identify music';
  String _artist = '';
  String _albumArt = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Main Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Album Art / Visualizer
                  _buildAlbumArt(),

                  SizedBox(height: 40),

                  // Song Info
                  _buildSongInfo(),

                  SizedBox(height: 60),

                  // Shazam Button
                  _buildShazamButton(),
                ],
              ),
            ),

            // Bottom Navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
          Text(
            'Shazam',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(Icons.history, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumArt() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[800],
        image: _albumArt.isNotEmpty
            ? DecorationImage(image: NetworkImage(_albumArt), fit: BoxFit.cover)
            : null,
      ),
      child: _albumArt.isEmpty
          ? Icon(Icons.music_note, color: Colors.grey[600], size: 60)
          : null,
    );
  }

  Widget _buildSongInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            _currentSong,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            _artist,
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildShazamButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isListening = !_isListening;
          if (_isListening) {
            // Start listening logic here
            _currentSong = 'Listening...';
            _artist = 'We are identifying the music around you';
          } else {
            // Stop listening logic here
            _currentSong = 'Song Name';
            _artist = 'Artist Name';
            _albumArt =
                'https://example.com/album-art.jpg'; // Replace with actual URL
          }
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isListening ? Colors.red : Colors.white,
        ),
        child: Icon(
          _isListening ? Icons.stop : Icons.mic,
          color: _isListening ? Colors.white : Colors.black,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.compass, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.grey[600]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.library_music, color: Colors.grey[600]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.grey[600]),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
