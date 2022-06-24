class SchoolModel {
  final String name;
  final String token;
  final String id;
  final List<Object> peoples;

  SchoolModel(
      {required this.name,
      required this.token,
      required this.id,
      required this.peoples});

  factory SchoolModel.fromJson(Map<String, dynamic> parsedJson) {
    return SchoolModel(
        name: parsedJson['name'],
        token: parsedJson['token'],
        id: parsedJson['id'],
        peoples: parsedJson['peoples']);
  }
}
