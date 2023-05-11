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

  @override
  void dispose() {
    textMsgController.dispose();
    chatScrollCtlr.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    try {
      await chatRepo.addConversation(userId, {
        'id': peerId,
        'lastMessage': textMsgController.text,
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch,
        'name': peer.value!['name']
      });

      await chatRepo.addConversation(peerId, {
        'id': userId,
        'lastMessage': textMsgController.text,
        'lastMessageTime': DateTime.now().millisecondsSinceEpoch,
        'name': userName
      });

      await chatRepo.sendMessage(chatId, {
        'from': userId,
        'to': peerId,
        'message': encrypt(textMsgController.text),
        'time': DateTime.now().millisecondsSinceEpoch,
        'id': DateTime.now().millisecondsSinceEpoch.toString()
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
