import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skills_w6_ipad/pages/home_page.dart';
import 'package:skills_w6_ipad/pages/photos_page.dart';
import 'package:skills_w6_ipad/pages/skills_page.dart';
import 'package:skills_w6_ipad/pages/videos_page.dart';
import 'package:skills_w6_ipad/providers/nav_provider.dart';

void main() {
  runApp(const MainApp());
  Get.put<NavProvider>(NavProvider());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final NavProvider _navProvider = Get.find<NavProvider>();
  @override
  Widget build(BuildContext context) {
    Widget getSelectedWidget() {
      if (_navProvider.selectedIndex.value == 0) return const HomePage();
      if (_navProvider.selectedIndex.value == 1) return const SkillsPage();
      if (_navProvider.selectedIndex.value == 2) return const PhotosPage();
      if (_navProvider.selectedIndex.value == 3) return const VideosPage();
      return const HomePage();
    }

    return GetMaterialApp(
      home: Scaffold(
        body: Obx(
          () => Row(
            children: [
              NavigationRail(
                leading: SizedBox(
                  width: 45,
                  child: Image.asset("assets/image.png"),
                ),
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (value) {
                  setState(() {
                    _navProvider.changeView(value);
                  });
                },
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text("Home"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.construction),
                    label: Text("Skills"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.photo_library),
                    label: Text("Photos"),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.video_camera_back),
                    label: Text("Videos"),
                  ),
                ],
                selectedIndex: _navProvider.selectedIndex.value,
              ),
              Expanded(child: getSelectedWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
