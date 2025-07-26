class Admin {
  final String uid;
  final List<String> roles;

  Admin({required this.uid, required this.roles});

  factory Admin.fromMap(String uid, Map<String, dynamic> data) {
    return Admin(
      uid: uid,
      roles: List<String>.from(data['roles'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roles': roles,
    };
  }
} 