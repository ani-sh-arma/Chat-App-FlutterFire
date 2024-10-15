import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/chat_controller.dart';
import '../../models/local_user.dart';
import '../../models/message.dart';
import '../widgets/message_widget.dart';

class ChatScreen extends StatelessWidget {
  final LocalUser localUser;
  final User user;
  final String chatId; // Pass the chat ID to identify the chat
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController messageController = TextEditingController();

  ChatScreen({
    super.key,
    required this.user,
    required this.chatId,
    required this.localUser,
  });

  void _sendMessage() {
    final text = messageController.text;
    if (text.isNotEmpty) {
      chatController.sendMessage(chatId, text, user.uid);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              localUser.fullName,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: chatController.getMessagesStream(chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return FutureBuilder<LocalUser?>(
                      future: getUserById(message.senderId),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return MessageWidget(
                            message: message,
                            senderName: "Loading...",
                          );
                        }
                        if (userSnapshot.hasError) {
                          return MessageWidget(
                            message: message,
                            senderName: "Unknown",
                          );
                        }
                        final sender = userSnapshot.data;
                        return message.text.startsWith('https://')
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      user.uid == message.senderId
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: Get.width * 0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        message.text,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) =>
                                                child,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : MessageWidget(
                                message: message,
                                senderName: sender?.fullName ?? 'Unknown',
                              );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.perm_media_outlined),
                  onPressed: () {
                    chatController.sendImage(chatId, user.uid);
                  },
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<LocalUser?> getUserById(String userId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        return LocalUser.fromDocument(doc);
      } else {
        return null; // User not found
      }
    } catch (e) {
      return null; // Handle errors appropriately
    }
  }
}
