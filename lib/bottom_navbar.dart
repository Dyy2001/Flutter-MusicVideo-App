import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_music_video/pages/music.dart';
import 'package:task_music_video/pages/video.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late final _routes = const [
    MusicPlayer(),
    VideoPlayer(),
  ];
  int _pilihtabbar = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = [
    Text(
      'Music',
      style: optionStyle,
    ),
    Text(
      'Video',
      style: optionStyle,
    ),
  ];

  void _changetabbar(int index) {
    setState(() {
      _pilihtabbar = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes[_pilihtabbar],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Video',
          ),
        ],
        currentIndex: _pilihtabbar,
        selectedItemColor: Colors.pink[300],
        unselectedItemColor: Colors.white,
        onTap: _changetabbar,
      ),
    );
  }
}
