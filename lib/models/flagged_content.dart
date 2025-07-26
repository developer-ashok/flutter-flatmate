// import 'package:cloud_firestore/cloud_firestore.dart';

class FlaggedContent {
  final String id;
  final String contentId;
  final String contentType;
  final String flaggedByUid;
  final String reason;
  final DateTime flaggedAt;
  final bool resolved;

  FlaggedContent({
    required this.id,
    required this.contentId,
    required this.contentType,
    required this.flaggedByUid,
    required this.reason,
    required this.flaggedAt,
    this.resolved = false,
  });

  // factory FlaggedContent.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return FlaggedContent(
  //     id: doc.id,
  //     contentId: data['contentId'] ?? '',
  //     contentType: data['contentType'] ?? '',
  //     flaggedByUid: data['flaggedByUid'] ?? '',
  //     reason: data['reason'] ?? '',
  //     flaggedAt: data['flaggedAt'] ?? Timestamp.now(),
  //     resolved: data['resolved'] ?? false,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'contentId': contentId,
      'contentType': contentType,
      'flaggedByUid': flaggedByUid,
      'reason': reason,
      'flaggedAt': flaggedAt.toIso8601String(),
      'resolved': resolved,
    };
  }
} 