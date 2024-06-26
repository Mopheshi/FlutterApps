import 'dart:convert';

/// A model class for the user
class UserModel {
  final int id;
  final bool isVerified;

  const UserModel(this.id, this.isVerified);

  /// Converts the map to a model
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      json['id'] as int,
      json['isVerified'] as bool,
    );
  }

  /// Converts the JSON string to a model
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  /// Converts the model to a map
  Map<String, dynamic> toMap() => {'id': id, 'isVerified': isVerified};

  /// Converts the model to a JSON string
  String toJson() => json.encode(toMap());
}
