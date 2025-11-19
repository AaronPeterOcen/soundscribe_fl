import 'package:flutter/material.dart';
import 'package:soundscribe_fl/screens/lyric_search.dart';
import 'package:soundscribe_fl/screens/shazam_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Audio Apps',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.indigoAccent,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.music_note), text: 'Shazam'),
            Tab(icon: Icon(Icons.audio_file), text: 'SoundScribe'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Home Tab
          Center(child: Text('Welcome to My Audio Apps')),

          // Shazam Tab - Your clone directly embedded
          ShazamUi(),

          // SoundScribe Tab
          // Center(child: Text('SoundScribe App')),
          LyricsSearch(),
          // GeniusSearchScreen(),
        ],
      ),
    );
  }
}
