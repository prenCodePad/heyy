import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';
import 'package:heyy/pages/home/widgets/heyy_textfield.dart';

enum AttachmentType { image, location, audio }

class ChatInput extends StatelessWidget with AppMixin {
  const ChatInput({Key? key}) : super(key: key);

  ChatController get chatController => Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: (Get.height) * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: Row(
        children: [
          HeyyTextField(controller: chatController.textMsgController),
          const SizedBox(width: 10),
          _sendActionButton(
            onTap: () {
              if (chatController.textMsgController.text.isNotEmpty) chatController.sendMessage();
            },
            child: const Icon(Icons.arrow_right_alt_outlined, color: Color(0xff1BD7BB)),
          )
        ],
      ),
    );
  }

  _sendActionButton({required Function() onTap, required Widget child}) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xff1BD7BB), width: 2),
              shape: BoxShape.circle),
          child: child,
        ));
  }

  // void _showMediaMenu(BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       backgroundColor: theme.bottomSheetBackground,
  //       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  //       builder: (BuildContext con) {
  //         return Container(
  //           padding: EdgeInsets.symmetric(vertical: (Get.height) * 0.05),
  //           height: (Get.height) * 0.22,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: AttachmentType.values.map((e) {
  //               switch (e) {
  //                 case AttachmentType.image:
  //                   return const ImageAttachment();
  //                 case AttachmentType.audio:
  //                   return const AudioAttachment();
  //                 case AttachmentType.location:
  //                   return const LocationAttachment();
  //               }
  //             }).toList(),
  //           ),
  //         );
  //       });
  // }
}
