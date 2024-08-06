class User {
  final String id;
  final String name;
  final String nodeId;

  User({
    required this.id,
    required this.name,
    required this.nodeId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      nodeId: json['nodeId'],
    );
  }
}