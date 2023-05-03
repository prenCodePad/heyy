import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/pages/pages.dart';
import 'package:heyy/routing/routes.dart';

class UserSetupScreen extends StatelessWidget with AppMixin {
  const UserSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          LoginBackground(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Profile Info', style: theme.displayTitle1(color: Colors.white)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 48,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: snc.nameController,
                        onChanged: snc.onUserNameChanged,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Type your name here',
                          contentPadding: const EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Obx(() {
                      return Button(
                          text: snc.setupLoader.value ? 'Signing in...' : 'Next',
                          onPressed: () async {
                            if (snc.nameController.text.isNotEmpty) {
                              if (!snc.setupLoader.value) {
                                await snc.setUser();
                                Navigator.pushNamed(context, Routes.homePage);
                              }
                            } else {
                              Get.snackbar("Error", "Please provide phone number", backgroundColor: Colors.white);
                            }
                          });
                    }),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Heyy',
                style: theme.hwHero(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
