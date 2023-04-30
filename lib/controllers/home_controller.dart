import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heyy/models/models.dart';
import 'package:uuid/uuid.dart';

enum ChatView { allChat, specificChat }

class HomeController extends GetxController {
  final counter = 0.obs;
  final users = User.users.obs;
  final userSelected = Rxn<User>();
  final chatView = ChatView.allChat.obs;
  final selectedUserMessages = <Message>[].obs;
  final userSearchResults = User.users.obs;

  updateCounter() => counter.value = counter.value + 1;
  final TextEditingController userSearchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final ScrollController chatController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  searchContact(String pattern) {
    if (pattern.isEmpty) {
      userSearchResults.value = users;
    } else {
      userSearchResults.value = users.where((p0) => p0.name.contains(RegExp(pattern, caseSensitive: false))).toList();
    }
  }

  selectContact(User? user) {
    userSelected.value = user;
    if (user == null) {
      chatView.value = ChatView.allChat;
      selectedUserMessages.value = [];
    } else {
      chatView.value = ChatView.specificChat;
      selectedUserMessages.value = user.messages;
    }
  }

  createMessage(String text) {
    var now = DateTime.now().millisecondsSinceEpoch;
    return Message(id: now.toString(), text: text, time: now, from: '', to: '');
  }

  addMessage(Message msg) {
    userSelected.value!.messages.add(msg);
    messageController.text = '';
    userSelected.refresh();
  }

  @override
  void dispose() {
    userSearchController.dispose();
    messageController.dispose();
    chatController.dispose();
    super.dispose();
  }
}
