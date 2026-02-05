import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  final VideoPlayerController _controller = VideoPlayerController.asset(
    "assets/1ee59149-c899-421e-aab0-7f5d301c9ea3.MP4",
  );
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await _controller.initialize();
    _controller.addListener(() {});
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text("Videos")),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      color: Colors.black,
                      child: Expanded(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onLongPressDown: (details) {
                                _controller.setPlaybackSpeed(2);
                              },
                              onLongPressUp: () =>
                                  _controller.setPlaybackSpeed(1),
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              height: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          if (_controller.value.isPlaying) {
                                            _controller.pause();
                                          } else {
                                            _controller.play();
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          _controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                        ),
                                      ),
                                      Row(
                                        spacing: 32,
                                        children: [
                                          StreamBuilder(
                                            stream: _controller.position
                                                .asStream(),
                                            builder: (context, asyncSnapshot) {
                                              if (!asyncSnapshot.hasData) {
                                                return Text("unkown duration");
                                              }
                                              return Text(
                                                "${asyncSnapshot.data!.inMinutes}:${asyncSnapshot.data!.inSeconds % 60}",
                                              );
                                            },
                                          ),
                                          Text(
                                            "${_controller.value.duration.inMinutes}:${_controller.value.duration.inSeconds % 60}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (isMuted) {
                                        _controller.setVolume(1);
                                      } else {
                                        _controller.setVolume(0);
                                      }
                                      setState(() {
                                        isMuted = !isMuted;
                                      });
                                    },
                                    icon: Icon(
                                      isMuted
                                          ? Icons.volume_up
                                          : Icons.volume_mute,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Video title"),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "type a new comment here",
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Publish"),
                              ),
                            ],
                          ),
                          Text("5 comments"),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("from 127.0.0.$index"),
                                  subtitle: Text("A very nice video i like it"),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("More videos"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: 200,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {},
                                    onLongPress: () async {},
                                    child: Image.network(
                                      "https://picsum.photos/200/200",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: Container(
                                    color: Colors.black54,
                                    child: Column(
                                      children: [
                                        Text(
                                          "1:30",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
