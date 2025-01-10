import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Replacing localstorage
import '../models/time_entry_model.dart';
import 'dart:convert';

class TimeEntryProvider extends ChangeNotifier {
  List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  Future<void> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('time_entries'); // ✅ Correct way to retrieve data

    if (storedData != null) {
      List<dynamic> jsonData = jsonDecode(storedData);
      _entries = jsonData.map((data) => TimeEntry.fromJson(data)).toList();
    }
    notifyListeners();
  }

  void addEntry(TimeEntry entry) async {
    _entries.add(entry);
    await _saveEntries(); // ✅ Saving after adding entry
    notifyListeners();
  }

  void deleteEntry(String id) async {
    _entries.removeWhere((entry) => entry.id == id);
    await _saveEntries(); // ✅ Saving after deleting entry
    notifyListeners();
  }

  Future<void> _saveEntries() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('time_entries', jsonEncode(_entries)); // ✅ Correct way to save
  }
}
