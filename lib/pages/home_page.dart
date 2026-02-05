import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skills_w6_ipad/providers/nav_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NavProvider _navProvider = Get.find<NavProvider>();
  final PageController _pageController = PageController();
  int selectedIndex = 0;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        selectedIndex = (selectedIndex + 1) % 3;
        _pageController.animateToPage(
          selectedIndex,
          duration: 200.milliseconds,
          curve: Curves.bounceIn,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text("Home")),
        SizedBox(
          height: Get.height / 2,
          child: Flexible(
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  children: [
                    for (int i = 0; i < 3; i++)
                      Image.asset("assets/$i.jpg", fit: BoxFit.cover),
                  ],
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 12,
                    children: [
                      for (int i = 0; i < 3; i++)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedIndex == i
                                ? Colors.white
                                : Colors.white54,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _navProvider.changeView(1);
                },
                child: Text("Skills"),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _navProvider.changeView(2);
                },
                child: Text("Photos"),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  _navProvider.changeView(3);
                },
                child: Text("Videos"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
