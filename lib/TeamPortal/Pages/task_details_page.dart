import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Models/TaskModel.dart'; // Import the Task Model

class TaskDetailsScreen extends StatefulWidget {
  final Task task;

  TaskDetailsScreen({required this.task});

  @override
  _TaskDetailsScreenState createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _checklistController = TextEditingController();
  List<String> checklistItems = [];
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // To handle overflow on small screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Title
              Text(
                widget.task.title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              const SizedBox(height: 8),

              // Task Description
              Text(
                widget.task.description,
                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
              ),
              const SizedBox(height: 12),

              // Location
              Text(
                "Location: ${widget.task.location}",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.red),
              ),
              const SizedBox(height: 20),
              // Checklist Section
              Text(
                "Checklist",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              const SizedBox(height: 8),
              ...checklistItems.map((item) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item,
                  style: TextStyle(fontSize: 16),
                ),
              )),
              const SizedBox(height: 8),
              TextField(
                controller: _checklistController,
                decoration: InputDecoration(
                  labelText: 'Enter new item',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (_checklistController.text.isNotEmpty) {
                    setState(() {
                      checklistItems.add(_checklistController.text);
                      _checklistController.clear();
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter an item to add to the checklist")),
                    );
                  }
                },
                child: const Text("Add to Checklist", style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),

              // Notes Section
              Text(
                "Notes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (text) {
                  setState(() {
                    notes = text;
                  });
                },
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Add your notes here...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),

              // Verify Payment Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20), backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // Action to verify payment
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Payment verified for ${widget.task.title}")),
                  );
                },
                child: const Text("Verify Payment", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
