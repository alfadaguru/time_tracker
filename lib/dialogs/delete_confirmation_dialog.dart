import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Confirm Deletion"),
      content: Text("Are you sure you want to delete this entry?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}
