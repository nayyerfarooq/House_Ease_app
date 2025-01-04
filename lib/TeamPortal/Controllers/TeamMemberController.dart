import 'package:get/get.dart';
import '../../Models/TaskModel.dart';

class TeamMemberController extends GetxController {
  var tasks = <Task>[].obs;
  var taskCompleted = false.obs;
  var paymentConfirmed = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDummyTasks();
  }

  void _initializeDummyTasks() {
    tasks.addAll([
      Task(
        title: "Deliver Furniture",
        description: "Deliver the sofa set to the client at 12:00 PM.",
        location: "Green Valley, Block 5",
        isCompleted: false,
      ),
      Task(
        title: "Pack Kitchen Items",
        description: "Pack all kitchen items safely for transportation.",
        location: "Rosewood Apartments, Apt 3B",
        isCompleted: false,
      ),
      Task(
        title: "Inspect Electrical Setup",
        description: "Check and report the electrical setup in the new house.",
        location: "Downtown Plaza, Suite 404",
        isCompleted: true,
      ),
      Task(
        title: "Unload Moving Truck",
        description: "Help unload the truck and arrange items.",
        location: "Sunny Hills, Villa 21",
        isCompleted: false,
      ),
    ]);
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void completeTask(int index, bool isCompleted) {
    tasks[index].isCompleted = isCompleted;
    tasks.refresh();
  }

  void confirmPayment(bool isConfirmed) {
    paymentConfirmed.value = isConfirmed;
  }
}
