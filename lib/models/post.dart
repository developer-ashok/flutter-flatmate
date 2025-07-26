// import 'package:cloud_firestore/cloud_firestore.dart';

enum PostType {
  lookingForRoom,
  offeringRoom,
  teamUp,
}

class Post {
  final String id;
  final PostType type;
  final String title;
  final String description;
  final double rentOrBudget;
  final String addressOrLocation;
  final String leaseType;
  final List<String> householdLifestyle;
  final List<String> photoUrls;
  final String userProfileId;
  final DateTime createdAt;
  final bool isActive;

  Post({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.rentOrBudget,
    required this.addressOrLocation,
    required this.leaseType,
    required this.householdLifestyle,
    required this.photoUrls,
    required this.userProfileId,
    required this.createdAt,
    this.isActive = true,
  });

  // factory Post.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Post(
  //     id: doc.id,
  //     type: PostType.values[data['type'] ?? 0],
  //     title: data['title'] ?? '',
  //     description: data['description'] ?? '',
  //     rentOrBudget: (data['rentOrBudget'] as num?)?.toDouble() ?? 0.0,
  //     addressOrLocation: data['addressOrLocation'] ?? '',
  //     leaseType: data['leaseType'] ?? '',
  //     householdLifestyle: List<String>.from(data['householdLifestyle'] ?? []),
  //     photoUrls: List<String>.from(data['photoUrls'] ?? []),
  //     userProfileId: data['userProfileId'] ?? '',
  //     createdAt: data['createdAt'] ?? Timestamp.now(),
  //     isActive: data['isActive'] ?? true,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'title': title,
      'description': description,
      'rentOrBudget': rentOrBudget,
      'addressOrLocation': addressOrLocation,
      'leaseType': leaseType,
      'householdLifestyle': householdLifestyle,
      'photoUrls': photoUrls,
      'userProfileId': userProfileId,
      'createdAt': createdAt.toIso8601String(),
      'isActive': isActive,
    };
  }
} 