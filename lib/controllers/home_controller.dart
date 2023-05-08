import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/config/storage_prefs.dart';
import 'package:heyy_backend/heyy_backend.dart';

enum ChatView { allChat, specificChat }

class HomeController extends GetxController {
  final counter = 0.obs;
  final users = <Map<String, dynamic>>[].obs;
  final userSelected = Rxn<User>();
  final chatView = ChatView.allChat.obs;

  final selectedUserMessages = <Message>[].obs;
  final userSearchResults = User.users.obs;

  final getChatsLoader = false.obs;

  updateCounter() => counter.value = counter.value + 1;
  final TextEditingController userSearchController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final ScrollController chatController = ScrollController();
  final ChatRepo _chatRepo = ChatRepoApi();
  final LoginRepo _loginRepo = LoginRepoImpl();

  String id = StoragePrefs.getStorageValue('id');

  @override
  void onInit() {
    getConversations();
    super.onInit();
  }

  getConversations() async {
    getChatsLoader.value = true;
    users.value = await _chatRepo.getConversations(id);
    getChatsLoader.value = false;
  }

  Future<List<Map<String, dynamic>>> searchUsers(String searchPhone) async {
    return (await _loginRepo.searchUser(searchPhone)).where((e) => e['id'] != id).toList();
  }

  selectContact(User? user) {
    userSelected.value = user;
    if (user == null) {
      chatView.value = ChatView.allChat;
      selectedUserMessages.value = [];
    } else {
      chatView.value = ChatView.specificChat;
      //selectedUserMessages.value = user.messages;
    }
  }

  var countryCodes = ['US', 'CA', 'AU', 'GB', 'IN', 'MX'];

  createMessage(String text) {
    var now = DateTime.now().millisecondsSinceEpoch;
    return Message(id: now.toString(), text: text, time: now, from: '', to: '');
  }

  addMessage(Message msg) {
    // userSelected.value!.messages.add(msg);
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
