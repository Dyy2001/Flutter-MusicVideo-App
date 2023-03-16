import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

Duration? duration = const Duration(seconds: 0);

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlayed = false;
  double value = 0;
  final playermusic = AudioPlayer();

  void initPlayer() async {
    await playermusic.setSource(AssetSource("rahmatan-lil-alamin.mp3"));

    duration = await playermusic.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Music Player Page"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black26,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/cover.jpg",
                  width: 250.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Rahmatan Lil Alamin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${(value / 60).floor()}:${(value % 60).floor()}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider.adaptive(
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                    },
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                        print(newValue);
                      });
                      playermusic.pause();
                      await playermusic
                          .seek(Duration(seconds: newValue.toInt()));
                    },
                    activeColor: Colors.white,
                  ),
                  Text(
                    "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: 300.0,
                height: 55.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  color: Colors.black26,
                  border: Border.all(color: Colors.pink),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.skip_previous, color: Colors.white),
                    ),
                    InkWell(
                      onTap: () async {
                        if (isPlayed) {
                          await playermusic.pause();
                          setState(() {
                            isPlayed = false;
                          });
                        } else {
                          await playermusic.resume();
                          setState(() {
                            isPlayed = true;
                          });
                          playermusic.onPositionChanged.listen(
                            (position) {
                              setState(
                                () {
                                  value = position.inSeconds.toDouble();
                                },
                              );
                            },
                          );
                        }
                      },
                      child: Icon(
                        isPlayed ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      iconSize: 40,
                      onPressed: () {},
                      icon: Icon(Icons.skip_next, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
