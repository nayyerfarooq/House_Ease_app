import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/mesage_controller.dart';
import '../Models/messsage_model.dart';

class AdminChatScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final MessageController _messageController = Get.put(MessageController());
  final TextEditingController _messageControllerText = TextEditingController();

  AdminChatScreen({super.key, required this.userId, required this.userName});

  @override
  Widget build(BuildContext context) {
    // Fetch messages when the screen is built
    _messageController.fetchMessages(userId, "0");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with Admin'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Messages List
            Expanded(
              child: Obx(() {
                // Show loading indicator
                if (_messageController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Check for empty messages
                if (_messageController.messages.isEmpty) {
                  return const Center(child: Text('No messages yet'));
                }

                // Safe ListView.builder to handle non-empty lists
                return ListView.builder(
                  itemCount: _messageController.messages.length,
                  itemBuilder: (context, index) {
                    // Check for valid index range
                    if (index >= _messageController.messages.length) {
                      return const SizedBox(); // Safe fallback
                    }

                    final message = _messageController.messages[index];
                    return MessageTile(message: message);
                  },
                );
              }),
            ),

            // Message Input Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  // Text Input
                  Expanded(
                    child: TextField(
                      controller: _messageControllerText,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Send Button
                  ElevatedButton(
                    onPressed: () {
                      if (_messageControllerText.text.isNotEmpty) {
                        try {
                          _messageController.sendMessageHandler(
                            int.parse(userId),
                            1,
                            userName,
                            'Admin',
                            _messageControllerText.text,
                          );
                          _messageControllerText.clear();
                        } catch (e) {
                          Get.snackbar(
                            'Error',
                            'Failed to send message: $e',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        Get.snackbar(
                          'Empty Message',
                          'Please type a message before sending.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(70, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the message time safely
    String formattedTime = '${message.messageTime.hour}:${message.messageTime.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
          message.senderId == 0 ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            // Sender Name
            Text(
              message.senderName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            // Message Content
            Text(message.content),
            const SizedBox(height: 5),

            // Message Time
            Text(
              formattedTime,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
