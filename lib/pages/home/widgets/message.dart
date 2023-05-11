import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';

enum MessageType { text, image, video, doc, location, contact, audio }

class Message extends StatelessWidget with AppMixin {
  final Map<String, dynamic> message;
  const Message({Key? key, required this.message}) : super(key: key);

  ChatController get chatCtlr => Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatCtlr.myMessage(message['from']) ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: Get.width * 0.8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
            color: chatCtlr.myMessage(message['from']) ? const Color(0xff1BD7BB) : Colors.white,
            border:
                Border.all(color: chatCtlr.myMessage(message['from']) ? Colors.transparent : const Color(0xff1BD7BB)),
            borderRadius: _borderRadius(chatCtlr.myMessage(message['from']))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextMessage(message: message),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chatCtlr.getTimeString(message['time']),
                    style: theme.bodySmall(
                        color: !chatCtlr.myMessage(message['from']) ? const Color(0xff1BD7BB) : Colors.white)),
                const SizedBox(width: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _borderRadius(bool right) {
    return right
        ? const BorderRadius.only(
            bottomLeft: Radius.circular(12), topLeft: Radius.circular(12), topRight: Radius.circular(12))
        : const BorderRadius.only(
            bottomRight: Radius.circular(12), topLeft: Radius.circular(12), topRight: Radius.circular(12));
  }
}

class TextMessage extends StatelessWidget with AppMixin {
  final Map<String, dynamic> message;
  const TextMessage({Key? key, required this.message}) : super(key: key);
  ChatController get chatCtlr => Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: Text(decrypt(message['message']),
                style: theme.body(color: chatCtlr.myMessage(message['from']) ? Colors.white : const Color(0xff1BD7BB)),
                textAlign: TextAlign.start)),
        SizedBox(width: Get.width * 0.15)
      ],
    );
  }
}

class _DateChip extends StatelessWidget with AppMixin {
  final String text;
  const _DateChip({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Chip(
        label: Text(text, style: theme.body(color: Colors.black)),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
