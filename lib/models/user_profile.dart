// import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String email;
  final String? displayName;
  final int? age;
  final String? gender;
  final String? occupation;
  final double? monthlyBudget;
  final List<String>? lifestyleTags;
  final DateTime? preferredMoveInDate;
  final List<String>? preferredLocations;
  final String? photoUrl;
  final bool isEmailVerified;

  UserProfile({
    required this.uid,
    required this.email,
    this.displayName,
    this.age,
    this.gender,
    this.occupation,
    this.monthlyBudget,
    this.lifestyleTags,
    this.preferredMoveInDate,
    this.preferredLocations,
    this.photoUrl,
    this.isEmailVerified = false,
  });

  // factory UserProfile.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return UserProfile(
  //     uid: doc.id,
  //     email: data['email'] ?? '',
  //     displayName: data['displayName'],
  //     age: data['age'],
  //     gender: data['gender'],
  //     occupation: data['occupation'],
  //     monthlyBudget: (data['monthlyBudget'] as num?)?.toDouble(),
  //     lifestyleTags: List<String>.from(data['lifestyleTags'] ?? []),
  //     preferredMoveInDate: data['preferredMoveInDate'] != null
  //         ? (data['preferredMoveInDate'] as Timestamp).toDate()
  //         : null,
  //     preferredLocations: List<String>.from(data['preferredLocations'] ?? []),
  //     photoUrl: data['photoUrl'],
  //     isEmailVerified: data['isEmailVerified'] ?? false,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'age': age,
      'gender': gender,
      'occupation': occupation,
      'monthlyBudget': monthlyBudget,
      'lifestyleTags': lifestyleTags,
      'preferredMoveInDate': preferredMoveInDate,
      'preferredLocations': preferredLocations,
      'photoUrl': photoUrl,
      'isEmailVerified': isEmailVerified,
    };
  }
} 