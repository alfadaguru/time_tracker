import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/time_entry_provider.dart';
import 'add_time_entry_screen.dart';
import 'project_task_management_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TimeEntryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Time Tracker")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Time Tracking Menu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            ListTile(
              leading: Icon(Icons.work),
              title: Text("Manage Projects & Tasks"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectTaskManagementScreen()));
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: provider.entries.length,
        itemBuilder: (context, index) {
          final entry = provider.entries[index];
          return ListTile(
            title: Text("Project ID: ${entry.projectId}"),
            subtitle: Text("Task ID: ${entry.taskId} - ${entry.totalTime} min"),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => provider.deleteEntry(entry.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTimeEntryScreen()));
        },
      ),
    );
  }
}
