import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/chat_controller.dart';
import 'package:heyy/controllers/home_controller.dart';
import 'package:heyy/pages/home/widgets/specific_chat.dart';
import 'package:heyy/pages/pages.dart';

class HomeScreen extends StatelessWidget with AppMixin {
  const HomeScreen({Key? key}) : super(key: key);
  HomeController get hc => Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (hc.chatView.value) {
        case ChatView.specificChat:
          return const SpecificChat();
        default:
          return const _AllChat();
      }
    });
  }
}

class _AllChat extends StatelessWidget with AppMixin {
  const _AllChat({Key? key}) : super(key: key);

  HomeController get hc => Get.put(HomeController());
  ChatController get cc => Get.put(ChatController());

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
              child: TypeAheadFormField<Map<String, dynamic>>(
                itemBuilder: (context, itemData) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black.withOpacity(0.1))),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(itemData['name'], style: theme.body(color: Colors.black)),
                        const SizedBox(height: 4),
                        Text(itemData['phone'], style: theme.body(color: Colors.black)),
                      ],
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  cc.peer.value = suggestion;
                  hc.chatView.value = ChatView.specificChat;
                },
                suggestionsCallback: (pattern) async {
                  if (pattern.length > 2) {
                    var items = await loginRepo.searchUser(pattern);
                    return items;
                  } else {
                    return [];
                  }
                },
                textFieldConfiguration: TextFieldConfiguration(
                  textAlign: TextAlign.center,
                  controller: hc.userSearchController,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.transparent.withOpacity(0.1),
                    hintText: 'Search Phone no',
                    hintStyle: const TextStyle(color: Colors.white),
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
          ),
        ],
      ),
      mainChild: StreamBuilder(
        stream: chatRepo.getStreamedConversations(hc.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var users = snapshot.data?.docs ?? [];

            if (users.isNotEmpty) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemBuilder: (_, i) {
                    var user = users[i].data() as Map<String, dynamic>;
                    return SizedBox(
                      height: 96,
                      child: InkWell(
                        onTap: () {
                          cc.peer.value = user;
                          hc.chatView.value = ChatView.specificChat;
                        },
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
                                    initials(user['name']),
                                    style: theme.beautyTitle1(color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user['name'], style: theme.displaySubTitle1()),
                                      Text(decrypt(user['lastMessage']), style: theme.body()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) => const SizedBox(height: 5),
                  itemCount: users.length);
            } else {
              return Center(
                  child: Text('Start chating!!!',
                      style: theme.beautyTitle1(color: const Color(0xff1BD7BB), fontStyle: FontStyle.italic)));
            }
          } else {
            return Center(
                child: Text('Start chating!!!',
                    style: theme.beautyTitle1(color: const Color(0xff1BD7BB), fontStyle: FontStyle.italic)));
          }
        },
      ),
    );
  }
}
