import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';
import 'package:heyy/pages/home/widgets/message.dart';

class ChatSession extends StatelessWidget with AppMixin {
  const ChatSession({Key? key}) : super(key: key);

  ChatController get chatCtlr => Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatRepo.getStreamedMessages(chatCtlr.chatId),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs ?? [];
            if (messages.isNotEmpty) {
              return ListView.separated(
                  reverse: true,
                  controller: chatCtlr.chatScrollCtlr,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  separatorBuilder: ((context, index) => const SizedBox(height: 12)),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => Message(message: messages[index].data() as Map<String, dynamic>));
            } else {
              return Center(
                  child: Text(
                'Start Chatting',
                style: theme.body(color: Colors.black),
              ));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
