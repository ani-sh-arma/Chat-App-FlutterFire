import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
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

  Stream<List<Message>> getMessagesStream(String chatId) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Message.fromDocument(doc)).toList());
  }
}
