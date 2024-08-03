import 'package:flutter/material.dart';
import '../../models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String senderName;

  const MessageWidget({
    super.key,
    required this.message,
    required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sender's name at the top
              Text(
                senderName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0), // Space between name and message
              // Message text
              Text(
                message.text,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4.0), // Space between message and timestamp
              // Timestamp aligned to the right
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  message.timestamp.toDate().toLocal().toString(),
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
    );
  }
}
