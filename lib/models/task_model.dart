class Task {
  String id;
  String projectId;
  String name;

  Task({required this.id, required this.projectId, required this.name});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(id: json['id'], projectId: json['projectId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "projectId": projectId, "name": name};
  }
}
