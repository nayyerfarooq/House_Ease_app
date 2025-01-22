import 'package:get/get.dart';
import '../Models/messsage_model.dart';
import '../services/api_service.dart';

class MessageController extends GetxController {
  final ApiService _apiService = ApiService();

  var messages = <Message>[].obs;
  var isLoading = false.obs;

  Future<void> fetchMessages(String senderId, String receiverId) async {
    try {
      isLoading.value = true;
      final fetchedMessages = await _apiService.fetchMessages(senderId, receiverId);
      messages.value = fetchedMessages;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Send a message
  Future<void> sendMessageHandler(int senderId, int receiverId, String senderName, String receiverName, String content) async {
    try {
      final message = Message(
        senderId: senderId,
        receiverId: receiverId,
        senderName: senderName,
        receiverName: receiverName,
        content: content,
        messageTime: DateTime.now(),
      );
      await _apiService.sendMessage(message);
      fetchMessages(senderId.toString(), receiverId.toString());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
