import 'package:get/get.dart';
class Message {
  final int id;
  final String message;
  Message({required this.id, required this.message});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }
}
class ApiController extends GetxController {
  // Observable list of messages
  var messages = <Message>[].obs;

  // Base URL for the API
  final String baseUrl = 'https://example.com/api/messages';

  // GET request to fetch messages from the API
  Future<void> fetchMessages() async {
    try {
      final response = await GetConnect().get(baseUrl);
      if (response.statusCode == 200) {
        List data = response.body;
        messages.value = data.map((json) => Message.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch messages');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  // POST request to send a new message to the API
  Future<void> addMessage(String newMessage) async {
    try {
      final response = await GetConnect().post(baseUrl, {
        'message': newMessage,
      });

      if (response.statusCode == 201) {
        // Add the new message to the observable list
        Message message = Message.fromJson(response.body);
        messages.add(message);
      } else {
        Get.snackbar('Error', 'Failed to add message');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to post message');
    }
  }

  // DELETE request to remove a message from the API
  Future<void> deleteMessage(int id) async {
    try {
      final response = await GetConnect().delete('$baseUrl/$id');

      if (response.statusCode == 200) {
        // Remove the deleted message from the observable list
        messages.removeWhere((message) => message.id == id);
      } else {
        Get.snackbar('Error', 'Failed to delete message');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
