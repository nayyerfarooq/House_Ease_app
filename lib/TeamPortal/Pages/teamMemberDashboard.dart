import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/CustomComponents/customLogoutDialog.dart';
import 'package:shift_ease_fyp/TeamPortal/Pages/task_details_page.dart';
import '../Models/AssignedTasksModal.dart';
import '../TeamPortalApis/TaskFetching.dart';


class TeamMemberDashboard extends StatelessWidget {
  final AssignedTasksController controller = Get.put(AssignedTasksController());

  TeamMemberDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Member Dashboard", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              controller.fetchAssignedTasks('1', 'alpha');
            },
          ),
          IconButton(
            onPressed: () {
              teamMemberLogoutDialog(context);
            },
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            ),
            const SizedBox(height: 8),
            const Text(
              "Here's an overview of your tasks.",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final processingTasks = controller.assignedTasks
                    .where((task) => task.orderStatus == 'Processing')
                    .toList();

                final completedTasks = controller.assignedTasks
                    .where((task) => task.orderStatus == 'Completed')
                    .toList();

                return ListView(
                  children: [
                    if (processingTasks.isNotEmpty) ...[
                      const Text(
                        "Processing Tasks",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                      const SizedBox(height: 8),
                      ...processingTasks.map((task) => TaskCard(task: task)).toList(),
                    ],
                    if (completedTasks.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      const Text(
                        "Completed Tasks",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      const SizedBox(height: 8),
                      ...completedTasks.map((task) => TaskCard(task: task)).toList(),
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final AssignedTasksModal task;

  const TaskCard({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(TaskDetailsScreen(task: task));
      },
      child: Card(
        color: Colors.orange[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.clientName,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              const SizedBox(height: 8),
              Text(task.location, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                  const SizedBox(width: 4),
                  Text(task.location, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      task.orderStatus,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: task.orderStatus == 'Processing' ? Colors.orange : Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}