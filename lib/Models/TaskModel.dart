class Task {
  final String title;
  final String description;
  final String location;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.location,
    this.isCompleted = false,
  });

  // A method to mark the task as completed
  void completeTask() {
    isCompleted = true;
  }

  // Convert a Task to a Map (useful for database operations or serialization)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'isCompleted': isCompleted,
    };
  }

  // Convert a Map to a Task (useful for reading data from a database)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      location: map['location'],
      isCompleted: map['isCompleted'],
    );
  }
}
