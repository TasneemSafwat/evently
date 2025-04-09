class UserModel {
  String name;
  String email;
  String id;
  List<String> favouriteEventIds;
  UserModel({
    required this.name,
    required this.id,
    required this.email,
    required this.favouriteEventIds,
  });
  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          name: json['name'],
          favouriteEventIds: (json['favouriteEventIds'] as List).cast<String>(),
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'favouriteEventIds': favouriteEventIds,
      };
}
