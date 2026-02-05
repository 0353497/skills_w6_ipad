import 'package:get/state_manager.dart';

class NavProvider extends GetxController {
  final selectedIndex = 0.obs;
  void changeView(int newIndex) {
    selectedIndex.value = newIndex;
  }
}
