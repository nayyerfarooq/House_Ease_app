import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/Pages/task_details_page.dart';
import '../Controllers/TeamMemberController.dart'; // Import the TeamMemberController

class TeamMemberDashboard extends StatelessWidget {
  const TeamMemberDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamMemberController controller = Get.put(TeamMemberController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Team Member Dashboard", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
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

            // Assigned (Pending) Tasks Section
            const Text(
              "Assigned Tasks (Pending)",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() {
              final pendingTasks = controller.tasks.where((task) => !task.isCompleted).toList();
              return pendingTasks.isEmpty
                  ? const Center(child: Text("No tasks assigned yet."))
                  : Expanded(
                child: ListView.builder(
                  itemCount: pendingTasks.length,
                  itemBuilder: (context, index) {
                    final task = pendingTasks[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to TaskDetailsScreen when a task is tapped
                        Get.to(() => TaskDetailsScreen(task: task));
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
                                task.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                              ),
                              const SizedBox(height: 8),
                              Text(task.description, style: const TextStyle(fontSize: 16, color: Colors.black87)),
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
                                    label: const Text("Pending", style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.orange,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.check_circle, color: Colors.green),
                                    onPressed: () {
                                      controller.completeTask(index, true);  // Mark task as completed
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 20),

            // Completed Tasks Section
            const Text(
              "Completed Tasks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
            ) ,
            const SizedBox(height: 10),
            Obx(() {
              final completedTasks = controller.tasks.where((task) => task.isCompleted).toList();
              return completedTasks.isEmpty
                  ? const Center(child: Text("No tasks completed yet."))
                  : Expanded(
                child: ListView.builder(
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return Card(
                      color: Colors.green[50],
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
                              task.title,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                            ),
                            const SizedBox(height: 8),
                            Text(task.description, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
                                const SizedBox(width: 4),
                                Text(task.location, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Chip(
                              label: Text("Completed", style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
