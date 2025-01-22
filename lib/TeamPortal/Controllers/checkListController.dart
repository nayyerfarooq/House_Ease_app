import 'package:get/get.dart';

class ChecklistController extends GetxController {
  var checklistItems = <String>[].obs;
  var checklistStatus = <bool>[].obs;

  void addItem(String item) {
    checklistItems.add(item);
    checklistStatus.add(false); // Default unchecked
  }

  void removeItem(int index) {
    checklistItems.removeAt(index);
    checklistStatus.removeAt(index);
  }

  void toggleItem(int index) {
    checklistStatus[index] = !checklistStatus[index];
  }
}
