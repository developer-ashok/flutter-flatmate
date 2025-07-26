// import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String chatId;
  final String senderUid;
  final String text;
  final DateTime sentAt;
  final bool isTypingIndicator;

  Message({
    required this.id,
    required this.chatId,
    required this.senderUid,
    required this.text,
    required this.sentAt,
    this.isTypingIndicator = false,
  });

  // factory Message.fromFirestore(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   return Message(
  //     id: doc.id,
  //     chatId: data['chatId'] ?? '',
  //     senderUid: data['senderUid'] ?? '',
  //     text: data['text'] ?? '',
  //     sentAt: data['sentAt'] ?? Timestamp.now(),
  //     isTypingIndicator: data['isTypingIndicator'] ?? false,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'senderUid': senderUid,
      'text': text,
      'sentAt': sentAt.toIso8601String(),
      'isTypingIndicator': isTypingIndicator,
    };
  }
} 