import 'package:flutter/material.dart';

class ProjectTaskManagementScreen extends StatefulWidget {
  @override
  _ProjectTaskManagementScreenState createState() => _ProjectTaskManagementScreenState();
}

class _ProjectTaskManagementScreenState extends State<ProjectTaskManagementScreen> {
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  List<String> _projects = [];
  Map<String, List<String>> _tasks = {};

  void _addProject() {
    setState(() {
      _projects.add(_projectController.text);
      _tasks[_projectController.text] = [];
      _projectController.clear();
    });
  }

  void _addTask(String project) {
    setState(() {
      _tasks[project]?.add(_taskController.text);
      _taskController.clear();
    });
  }

  void _deleteProject(String project) {
    setState(() {
      _projects.remove(project);
      _tasks.remove(project);
    });
  }

  void _deleteTask(String project, String task) {
    setState(() {
      _tasks[project]?.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Projects & Tasks")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _projectController,
              decoration: InputDecoration(
                labelText: "New Project",
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addProject,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _projects.length,
                itemBuilder: (context, index) {
                  String project = _projects[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ExpansionTile(
                      title: Text(project),
                      children: [
                        TextField(
                          controller: _taskController,
                          decoration: InputDecoration(
                            labelText: "New Task",
                            suffixIcon: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => _addTask(project),
                            ),
                          ),
                        ),
                        Column(
                          children: _tasks[project]!.map((task) {
                            return ListTile(
                              title: Text(task),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteTask(project, task),
                              ),
                            );
                          }).toList(),
                        ),
                        TextButton(
                          onPressed: () => _deleteProject(project),
                          child: Text("Delete Project", style: TextStyle(color: Colors.red)),
                        )
                      ],
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
