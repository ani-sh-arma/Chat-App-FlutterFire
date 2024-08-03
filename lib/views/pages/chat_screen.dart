import 'package:flutter/material.dart';
import '../../models/user.dart';

class ChatScreen extends StatelessWidget {
  final User user;
  ChatScreen({super.key, required this.user});

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Expanded widget to hold the chat messages
          Expanded(
            child: Center(
              child: Text('Chat screen for ${user.fullName}'),
            ),
          ),
          // Input field with send button
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.blue[100],
                    child: const TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue[100],
                  child: IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      // Handle send button press
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
