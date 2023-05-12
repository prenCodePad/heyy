import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/config/storage_prefs.dart';
import 'package:heyy/controllers/controllers.dart';
import 'package:heyy_backend/heyy_backend.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController with AppMixin {
  var peer = Rxn<Map<String, dynamic>>();
  var sendingTextMessage = false.obs;

  var userId = StoragePrefs.getStorageValue('id');
  var userName = StoragePrefs.getStorageValue('name');
  TextEditingController textMsgController = TextEditingController();
  ScrollController chatScrollCtlr = ScrollController();

  bool myMessage(String id) => id == userId;
  String getTimeString(int epoch) => DateFormat.Hm().format(convertDateTime(epoch));
  String get peerId => peer.value?['id'] ?? '';
  String get chatId => Common.getChatId(userId, peerId);
  void onTypingMessage() {
    if (textMsgController.text.isEmpty) sendingTextMessage.value = false;
    if (textMsgController.text.isNotEmpty) sendingTextMessage.value = true;
  }

  String k =
      'AAAAaNIFBS8:APA91bEwNORIHx00oqVmf-LJZxvaJJcNeo7rdJa7Llw8rMdanocIx56yCW0u7ISEoZ4ewVXp77ZMg1JtNroUY0QKDxR6PHGa2lz0XL8xKuUUg87YbJou_68-Oh-mE1Y2QO6g7cjQPYbn';

  @override
  void dispose() {
    textMsgController.dispose();
    chatScrollCtlr.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    try {
      var message = textMsgController.text;
      textMsgController.clear();

      await chatRepo.sendMessage(chatId, {
        'from': userId,
        'to': peerId,
        'message': encrypt(message),
        'time': DateTime.now().millisecondsSinceEpoch,
        'id': DateTime.now().millisecondsSinceEpoch.toString()
      }).then((value) {
        notificationRepo.sendMessagePushNotification(
            NotificationResponse(
                to: peerId,
                body: 'A new message received',
                data: {'peerId': peerId},
                recieverId: peerId,
                senderId: userId,
                title: userName),
            k);
      });
      chatRepo.addConversation(userId, {
        'id': peerId,
        'lastMessage': encrypt(message),
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch,
        'name': peer.value!['name']
      });

      chatRepo.addConversation(peerId, {
        'id': userId,
        'lastMessage': encrypt(message),
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch,
        'name': userName
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
