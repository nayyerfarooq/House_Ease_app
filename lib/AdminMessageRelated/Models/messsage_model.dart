class Message {
  final int senderId;
  final int receiverId;
  final String senderName;
  final String receiverName;
  final String content;
  final DateTime messageTime;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.content,
    required this.messageTime,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      content: json['content'],
      messageTime: DateTime.parse(json['message_time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'content': content,
      'message_time': messageTime.toIso8601String(),
    };
  }
}

