class SubjectModel {
  final String name;
  final String id;

  SubjectModel({required this.name, required this.id});

  factory SubjectModel.fromJson(Map<String, dynamic> parsedJson) {
    return SubjectModel(name: parsedJson['name'], id: parsedJson['id']);
  }
}
