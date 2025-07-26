// import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  final String id;
  final List<String> memberUids;
  final Map<String, dynamic> mergedProfile;
  final List<String> savedListingIds;
  final String? chatId;
  final DateTime createdAt;

  Group({
    required this.id,
    required this.memberUids,
    required this.mergedProfile,
    required this.savedListingIds,
    this.chatId,
    required this.createdAt,
  });

  // factory Group.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Group(
  //     id: doc.id,
  //     memberUids: List<String>.from(data['memberUids'] ?? []),
  //     mergedProfile: Map<String, dynamic>.from(data['mergedProfile'] ?? {}),
  //     savedListingIds: List<String>.from(data['savedListingIds'] ?? []),
  //     chatId: data['chatId'],
  //     createdAt: data['createdAt'] ?? Timestamp.now(),
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'memberUids': memberUids,
      'mergedProfile': mergedProfile,
      'savedListingIds': savedListingIds,
      'chatId': chatId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 