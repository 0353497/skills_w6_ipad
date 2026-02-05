import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  List<Future<Uint8List>> images = [];
  int selectedPage = 1;
  final int totalPages = 10;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text("Photos")),
        Expanded(
          child: LayoutBuilder(
            builder: (_, contrainsts) {
              return GridView.count(
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                crossAxisCount: contrainsts.maxWidth >= 576 ? 3 : 2,
                children: [
                  for (int i = 0; i < 6; i++)
                    FutureBuilder(
                      future: images[i],
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (!asyncSnapshot.hasData) {
                          return Text("Something went wrong");
                        }
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    Dialog.fullscreen(
                                      child: InteractiveViewer(
                                        child: Image.memory(
                                          width: Get.width - 50,
                                          asyncSnapshot.data!,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onLongPress: () async {
                                  final temp = await getTemporaryDirectory();
                                  final path = '${temp.path}/shared_image.jpg';
                                  File(
                                    path,
                                  ).writeAsBytesSync(asyncSnapshot.data!);

                                  SharePlus.instance.share(
                                    ShareParams(files: [XFile(path)]),
                                  );
                                },
                                child: Image.memory(
                                  asyncSnapshot.data!,
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
                                      "Populiarity: 230",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Visit: 3500",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedPage != 1) _pageButton(1),

            if (selectedPage > 3) const Text(" ... "),

            if (selectedPage > 2) _pageButton(selectedPage - 1),

            _pageButton(selectedPage, isActive: true),

            if (selectedPage < totalPages - 1) _pageButton(selectedPage + 1),

            if (selectedPage < totalPages - 2) const Text(" ... "),
            if (selectedPage != totalPages) _pageButton(totalPages),
          ],
        ),
      ],
    );
  }

  Widget _pageButton(int page, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        images = [];
        init();
        setState(() {
          selectedPage = page;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          "$page",
          style: TextStyle(
            color: isActive ? Colors.white : Colors.blue,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Future<Uint8List> loadImage(int i) async {
    final response = await http.get(
      Uri.parse("https://picsum.photos/20$i/20$i"),
    );
    return response.bodyBytes;
  }

  void init() async {
    for (var i = 0; i < 6; i++) {
      images.add(loadImage(i));
    }
    setState(() {});
  }
}
