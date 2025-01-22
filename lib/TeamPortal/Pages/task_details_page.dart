import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/Models/AssignedTasksModal.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../Controllers/checkListController.dart';

class TaskDetailsScreen extends StatefulWidget {
  final AssignedTasksModal task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final ChecklistController _checklistController = Get.put(ChecklistController());
  final TextEditingController _itemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
         title:  "Task Details",
          color: Colors.white, weight: FontWeight.bold,
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        title: "Package ID: ${widget.task.packageId}",
                        size: 24, weight: FontWeight.bold, color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 8),
                      CustomTextWidget(
                       title:  "Client: ${widget.task.clientName}",
                        size: 18, color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      CustomTextWidget(
                        title: "Location: ${widget.task.location}",
                        size: 16, color: Colors.red,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to map screen or show map
                        },
                        icon: const Icon(Icons.map, color: Colors.white),
                        label: const CustomTextWidget(title: "View Location on Map",color: Colors.white,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const CustomTextWidget(
               title:  "Checklist",
                size: 22, weight: FontWeight.bold, color: Colors.blueAccent,
              ),
              const SizedBox(height: 8),
              Obx(() => Column(
                children: List.generate(_checklistController.checklistItems.length, (index) {
                  return ListTile(
                    leading: Checkbox(
                      value: _checklistController.checklistStatus[index],
                      onChanged: (value) {
                        _checklistController.toggleItem(index);
                      },
                    ),
                    title: Text(_checklistController.checklistItems[index], style: const TextStyle(fontSize: 16)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _checklistController.removeItem(index);
                      },
                    ),
                  );
                }),
              )),
              const SizedBox(height: 8),
              TextField(
                controller: _itemController,
                decoration: InputDecoration(
                  labelText: 'Enter new item',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  if (_itemController.text.isNotEmpty) {
                    _checklistController.addItem(_itemController.text);
                    _itemController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: CustomTextWidget(title: "Please enter an item to add to the checklist")),
                    );
                  }
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Add to Checklist"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Payment verified for ${widget.task.packageId}")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      elevation: 5,
                    ),
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: const CustomTextWidget(
                      title: "Confirm Payment",
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Order completed for ${widget.task.packageId}")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                      elevation: 5,
                    ),
                    icon: const Icon(Icons.done_all, color: Colors.white),
                    label: const CustomTextWidget(
                      title: "Order Completed",
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
