import 'package:flutter/material.dart';

// MODEL CLASS: Represents a Task (OOP: Class + Encapsulation)
class Task {
  final String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  void toggleComplete() {
    isCompleted = !isCompleted;
  }
}

// TASK MANAGER: Manages the list of tasks (OOP: Abstraction + SRP)
class TaskManager {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(String title) {
    _tasks.add(Task(title: title));
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
  }

  void toggleTask(int index) {
    _tasks[index].toggleComplete();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OOP Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TaskPage(title: 'OOP Task Manager'),
    );
  }
}

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.title});
  final String title;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskManager _taskManager = TaskManager();
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    String taskTitle = _controller.text.trim();
    if (taskTitle.isNotEmpty) {
      setState(() {
        _taskManager.addTask(taskTitle);
        _controller.clear();
      });
    }
  }

  void _toggleComplete(int index) {
    setState(() {
      _taskManager.toggleTask(index);
    });
  }

  void _removeTask(int index) {
    setState(() {
      _taskManager.removeTask(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _addTask, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 20),
            // Task list
            Expanded(
              child: ListView.builder(
                itemCount: _taskManager.tasks.length,
                itemBuilder: (context, index) {
                  final task = _taskManager.tasks[index];
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(
                        task.isCompleted
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task.isCompleted ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => _toggleComplete(index),
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration:
                            task.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
