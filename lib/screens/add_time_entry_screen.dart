import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_entry_provider.dart';
import '../models/time_entry_model.dart';
import 'package:uuid/uuid.dart';

class AddTimeEntryScreen extends StatefulWidget {
  @override
  _AddTimeEntryScreenState createState() => _AddTimeEntryScreenState();
}

class _AddTimeEntryScreenState extends State<AddTimeEntryScreen> {
  final TextEditingController _projectController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final Uuid uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Time Entry")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _projectController, decoration: InputDecoration(labelText: "Project ID")),
            TextField(controller: _taskController, decoration: InputDecoration(labelText: "Task ID")),
            TextField(controller: _timeController, decoration: InputDecoration(labelText: "Total Time (minutes)"), keyboardType: TextInputType.number),
            TextField(controller: _notesController, decoration: InputDecoration(labelText: "Notes")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final entry = TimeEntry(
                  id: uuid.v4(),
                  projectId: _projectController.text,
                  taskId: _taskController.text,
                  totalTime: int.parse(_timeController.text),
                  date: DateTime.now(),
                  notes: _notesController.text,
                );
                Provider.of<TimeEntryProvider>(context, listen: false).addEntry(entry);
                Navigator.pop(context);
              },
              child: Text("Save Entry"),
            )
          ],
        ),
      ),
    );
  }
}
