// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/user_profile.dart';
// import '../models/post.dart';
// import '../models/group.dart';
// import '../models/message.dart';
// import '../models/saved_listing.dart';
// import '../models/flagged_content.dart';
// import '../models/analytics_event.dart';

class FirestoreService {
  // static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User Profile Methods
  // static Future<void> createUserProfile(UserProfile profile) async {
  //   await _firestore.collection('users').doc(profile.uid).set(profile.toMap());
  // }

  // static Future<UserProfile?> getUserProfile(String uid) async {
  //   final doc = await _firestore.collection('users').doc(uid).get();
  //   if (doc.exists) {
  //     return UserProfile.fromFirestore(doc);
  //   }
  //   return null;
  // }

  // static Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
  //   await _firestore.collection('users').doc(uid).update(data);
  // }

  // Post Methods
  // static Future<String> createPost(Post post) async {
  //   final docRef = await _firestore.collection('posts').add(post.toMap());
  //   return docRef.id;
  // }

  // static Stream<List<Post>> getPostsStream() {
  //   return _firestore
  //       .collection('posts')
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList());
  // }

  // static Future<List<Post>> searchPosts(String query) async {
  //   final snapshot = await _firestore
  //       .collection('posts')
  //       .where('title', isGreaterThanOrEqualTo: query)
  //       .where('title', isLessThan: query + '\uf8ff')
  //       .get();
  //   return snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
  // }

  // Group Methods
  // static Future<String> createGroup(Group group) async {
  //   final docRef = await _firestore.collection('groups').add(group.toMap());
  //   return docRef.id;
  // }

  // static Future<Group?> getGroup(String groupId) async {
  //   final doc = await _firestore.collection('groups').doc(groupId).get();
  //   if (doc.exists) {
  //     return Group.fromFirestore(doc);
  //   }
  //   return null;
  // }

  // Message Methods
  // static Future<void> sendMessage(Message message) async {
  //   await _firestore.collection('messages').add(message.toMap());
  // }

  // static Stream<List<Message>> getMessagesStream(String conversationId) {
  //   return _firestore
  //       .collection('messages')
  //       .where('conversationId', isEqualTo: conversationId)
  //       .orderBy('sentAt', descending: true)
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs.map((doc) => Message.fromFirestore(doc)).toList());
  // }

  // Saved Listings Methods
  // static Future<void> saveListing(SavedListing listing) async {
  //   await _firestore.collection('saved_listings').add(listing.toMap());
  // }

  // static Future<List<SavedListing>> getSavedListings(String userId) async {
  //   final snapshot = await _firestore
  //       .collection('saved_listings')
  //       .where('userId', isEqualTo: userId)
  //       .get();
  //   return snapshot.docs.map((doc) => SavedListing.fromFirestore(doc)).toList();
  // }

  // Flagged Content Methods
  // static Future<void> flagContent(FlaggedContent content) async {
  //   await _firestore.collection('flagged_content').add(content.toMap());
  // }

  // Analytics Methods
  // static Future<void> logEvent(AnalyticsEvent event) async {
  //   await _firestore.collection('analytics').add(event.toMap());
  // }
} 