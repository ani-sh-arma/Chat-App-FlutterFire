import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String senderName;

  MessageWidget({
    super.key,
    required this.message,
    required this.senderName,
  });

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: user?.uid == message.senderId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Container(
            width: Get.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: user?.uid == message.senderId
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0))
                  : const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                      bottomRight: Radius.circular(12.0)),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.uid == message.senderId ? 'You' : senderName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    message.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.timestamp
                          .toDate()
                          .toLocal()
                          .toString()
                          .substring(0, 19),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
