import 'package:http/http.dart' as http;
import 'package:shift_ease_fyp/apiUrl.dart';
import 'dart:convert';
import '../../AdminMessageRelated/Models/messsage_model.dart';

class ApiService {
  Future<List<Message>> fetchMessages(String senderId, String receiverId) async {
    final url = '${ApiUrl.baseUrl}/MessageApis/userMessage/?receiverId=$receiverId&senderId=$senderId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((message) => Message.fromJson(message)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

  Future<void> sendMessage(Message message) async {
    const url = '${ApiUrl.baseUrl}/MessageApis/userMessage/';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(message.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final url = '${ApiUrl.baseUrl}/MessageApis/userMessage/?messageId=$messageId';
    final response = await http.delete(Uri.parse(url));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete message');
    }
  }
}
