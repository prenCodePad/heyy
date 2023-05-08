import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/home_controller.dart';
import 'package:heyy/pages/pages.dart';

class HomeScreen extends StatelessWidget with AppMixin {
  const HomeScreen({Key? key}) : super(key: key);
  HomeController get hc => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (hc.chatView.value) {
        case ChatView.specificChat:
          return const _SpecificChat();
        default:
          return const _AllChat();
      }
    });
  }
}

class _AllChat extends StatelessWidget with AppMixin {
  const _AllChat({Key? key}) : super(key: key);

  HomeController get hc => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      headingChild: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chat with\nyour friends',
                  textAlign: TextAlign.left,
                  style: theme.displayTitle1(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: PopupMenuButton(
                      color: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: const Text(
                                'Log Out',
                                style: TextStyle(color: Colors.black),
                              ),
                              onTap: () async => await logoutUser())
                        ];
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 30, top: 20),
            child: SizedBox(
              height: 48,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: hc.userSearchController,
                //onChanged: hc.searchUser,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  fillColor: Colors.transparent.withOpacity(0.1),
                  filled: true,
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                  contentPadding: const EdgeInsets.all(16.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      mainChild: Obx(
        () {
          var users = hc.userSearchResults;

          return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (_, i) => SizedBox(
                    height: 96,
                    child: InkWell(
                      //onTap: () => hc.selectUser(users[i]),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 36,
                                backgroundColor: const Color(0xff1BD7BB),
                                child: Text(
                                  users[i].initials,
                                  style: theme.beautyTitle1(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(users[i].name, style: theme.displaySubTitle1()),
                                    //Text(users[i].messages.last.text, style: theme.body()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (_, i) => const SizedBox(height: 5),
              itemCount: users.length);
        },
      ),
    );
  }
}

class _SpecificChat extends StatelessWidget with AppMixin {
  const _SpecificChat({Key? key}) : super(key: key);

  HomeController get hc => Get.put(HomeController());

  List<Widget> _listOfMessages() {
    var user = hc.userSelected.value!;
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
                  // onPressed: () => hc.selectUser(null),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  hc.userSelected.value!.name,
                  textAlign: TextAlign.left,
                  style: theme.displayTitle1(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        mainChild: Obx(() {
          return SingleChildScrollView(
              reverse: true,
              child: Column(children: _listOfMessages()

                  //   children: [
                  //   Align(
                  //       alignment: Alignment.centerLeft,
                  //       child: Container(constraints: BoxConstraints(maxWidth: sizes.sw(0.5)), child: Text('Hii'))),
                  // ]
                  ));
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
        }));
  }
}
