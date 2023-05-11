import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';
import 'package:heyy/controllers/home_controller.dart';
import 'package:heyy/pages/home/widgets/chat_input.dart';
import 'package:heyy/pages/home/widgets/chat_session.dart';
import 'package:heyy/pages/home/widgets/home_layout.dart';

class SpecificChat extends StatelessWidget with AppMixin {
  const SpecificChat({Key? key}) : super(key: key);

  HomeController get hc => Get.put(HomeController());
  ChatController get cc => Get.put(ChatController());

  List<Widget> _listOfMessages() {
    var messages = hc.selectedUserMessages;
    List<Widget> m = <Widget>[];
    for (int i = 0; i <= messages.length; i++) {
      var msg = messages[0];
      m.add(i == 0
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: SizedBox(
                height: 48,
                child: TextFormField(
                  controller: hc.messageController,
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    filled: true,
                    suffixIcon: IconButton(
                      // onPressed: () => hc.addMessage(
                      //   hc.createMessage(hc.messageController.text, true),
                      // ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        size: 30,
                        color: Color(0xff1BD7BB),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
              ),
            )
          : false
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: const Color(0xff1BD7BB),
                  ),
                  constraints: BoxConstraints(maxWidth: sizes.sw(0.5)),
                  padding: const EdgeInsets.all(16),
                  child: Text(msg.text, style: theme.body(color: Colors.white)))
              : Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(maxWidth: sizes.sw(0.5)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xff1BD7BB), width: 0.3),
                  ),
                  child: Text(msg.text, style: theme.body()),
                ));
    }
    return m;
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        headingPanelheight: sizes.sh(0.2),
        headingChild: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    cc.peer.value = null;
                    hc.chatView.value = ChatView.allChat;
                  },
                  icon: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  cc.peer.value?['name'] ?? 'user',
                  textAlign: TextAlign.left,
                  style: theme.displayTitle1(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        mainChild: Column(mainAxisSize: MainAxisSize.max, children: const [
          Expanded(child: ChatSession()),
          ChatInput(),
        ])

        // Obx(() {
        //   return SingleChildScrollView(
        //       reverse: true,
        //       child: Column(children:

        //        _listOfMessages()

        //           //   children: [
        //           //   Align(
        //           //       alignment: Alignment.centerLeft,
        //           //       child: Container(constraints: BoxConstraints(maxWidth: sizes.sw(0.5)), child: Text('Hii'))),
        //           // ]
        //           ));
        // return ListView.separated(
        //     padding: const EdgeInsets.all(8),
        //     reverse: true,
        //     itemBuilder: (_, i) {
        //       if (i == 0) {
        //         return Padding(
        //           padding: const EdgeInsets.only(left: 12, right: 12),
        //           child: SizedBox(
        //             height: 48,
        //             child: TextFormField(
        //               controller: hc.messageController,
        //               decoration: InputDecoration(
        //                 fillColor: Colors.transparent,
        //                 filled: true,
        //                 suffixIcon: IconButton(
        //                   onPressed: () => hc.addMessage(
        //                     hc.createMessage(hc.messageController.text, true),
        //                   ),
        //                   icon: const Icon(
        //                     Icons.arrow_circle_right,
        //                     size: 30,
        //                     color: Color(0xff1BD7BB),
        //                   ),
        //                 ),
        //                 contentPadding: const EdgeInsets.all(16.0),
        //                 border: OutlineInputBorder(
        //                   borderRadius: BorderRadius.circular(25.0),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       } else {
        //         var msg = messages[messages.length - i];
        //         return msg.isMine
        //             ? ListTile(
        //                 trailing: Container(
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(24),
        //                       color: const Color(0xff1BD7BB),
        //                     ),
        //                     constraints: BoxConstraints(maxWidth: sizes.sw(0.5)),
        //                     padding: const EdgeInsets.all(16),
        //                     child: Text(msg.text, style: theme.body(color: Colors.white))),
        //               )
        //             : ListTile(
        //                 leading: Container(
        //                   padding: const EdgeInsets.all(16),
        //                   constraints: BoxConstraints(maxWidth: sizes.sw(0.5)),
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(24),
        //                     border: Border.all(color: const Color(0xff1BD7BB), width: 0.3),
        //                   ),
        //                   child: Text(msg.text, style: theme.body()),
        //                 ),
        //               );
        //       }
        //     },
        //     separatorBuilder: (_, i) {
        //       return const SizedBox(height: 20);
        //     },
        //     itemCount: messages.length + 1);
        // }
        // )
        );
  }
}
