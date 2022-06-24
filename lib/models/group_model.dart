class GroupModel {
  final String name;
  final String id;
  final List<Object> peoples;

  GroupModel({required this.name, required this.id, required this.peoples});

  factory GroupModel.fromJson(Map<String, dynamic> parsedJson) {
    return GroupModel(
        name: parsedJson['name'],
        id: parsedJson['id'],
        peoples: parsedJson['peoples']);
  }
}
