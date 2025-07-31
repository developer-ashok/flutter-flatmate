// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  // static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload Profile Picture
  // static Future<String> uploadProfilePicture(String userId, File imageFile) async {
  //   final ref = _storage.ref().child('profile_pictures/$userId.jpg');
  //   final uploadTask = ref.putFile(imageFile);
  //   final snapshot = await uploadTask;
  //   return await snapshot.ref.getDownloadURL();
  // }

  // Upload Post Images
  // static Future<List<String>> uploadPostImages(String postId, List<File> imageFiles) async {
  //   final urls = <String>[];
  //   for (int i = 0; i < imageFiles.length; i++) {
  //     final ref = _storage.ref().child('post_images/$postId/image_$i.jpg');
  //     final uploadTask = ref.putFile(imageFiles[i]);
  //     final snapshot = await uploadTask;
  //     urls.add(await snapshot.ref.getDownloadURL());
  //   }
  //   return urls;
  // }

  // Delete Image
  // static Future<void> deleteImage(String imageUrl) async {
  //   final ref = _storage.refFromURL(imageUrl);
  //   await ref.delete();
  // }
} 