class Note {
  int? id;
  String? title;
  String? description;
  String? imagePath;
  DateTime? createDate;

  Note({
    this.id,
    this.title,
    this.description,
    this.imagePath,
    this.createDate
  });

  Note.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    imagePath = json["imagePath"];
    createDate = DateTime.parse(json["createDate"]);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data["id"] = id;
    data["title"] = title;
    data["description"] = description;
    data["imagePath"] = imagePath;
    data["createDate"] = createDate?.toIso8601String();
    return data;
  }

}