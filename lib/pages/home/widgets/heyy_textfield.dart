import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';

class HeyyTextField extends StatelessWidget with AppMixin {
  final TextEditingController? controller;
  //final List<Widget>? trailingWidgets;
  const HeyyTextField({Key? key, this.controller}) : super(key: key);

  ChatController get textMsgCtlr => Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff1BD7BB), width: 2),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        child: TextField(
            showCursor: true,
            maxLines: null,
            onChanged: (value) {
              textMsgCtlr.onTypingMessage();
            },
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(fontSize: 16.0, color: Color(0xff1BD7BB)),
            controller: controller,
            decoration: chatInputDecoration(
                trailing: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, children: []))),
      ),
    );
  }

  InputDecoration chatInputDecoration({Widget? trailing}) => InputDecoration(
        enabledBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.5),
        ),
        hoverColor: Colors.transparent,
        focusedBorder: OutlineInputBorder(
          // width: 0.0 produces a thin "hairline" border
          borderRadius: BorderRadius.circular(1),
          borderSide: const BorderSide(color: Colors.transparent, width: 1.5),
        ),
        suffixIcon: trailing,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1), borderSide: const BorderSide(color: Colors.transparent)),
        contentPadding: const EdgeInsets.fromLTRB(10, 4, 7, 4),
        hintText: 'Message',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
      );
}
