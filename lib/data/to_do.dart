class ToDo {
  int? id;
  String? title;
  String? description;
  String? dueDate;
  String? createdAt;
  String? updatedAt;

  ToDo(
      {this.id,
      this.title,
      this.description,
      this.dueDate,
      this.createdAt,
      this.updatedAt});

  ToDo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['due_date'] = this.dueDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
