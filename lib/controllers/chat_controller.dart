import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/message.dart';

class ChatController extends GetxController {
  Future<void> sendMessage(String chatId, String text, String senderId) async {
    final message = Message(
      text: text,
      senderId: senderId,
      timestamp: Timestamp.now(),
    );

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());
  }

  // Method to handle image upload and send as a message
  Future<void> sendImage(String chatId, String senderId) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      try {
        // Get file name and upload to Firebase Storage
        final fileName = basename(pickedFile.path);
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('chat_images/$chatId/$fileName');

        UploadTask uploadTask = storageRef.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;

        // Get download URL
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Send the image URL as a message
        sendMessage(chatId, downloadUrl, senderId);
      } catch (e) {
        Get.snackbar("Error", 'Error occurred during image upload: $e');
      }
    }
  }

  Stream<List<Message>> getMessagesStream(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromDocument(doc)).toList(),
        );
  }
}
