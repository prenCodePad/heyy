import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/controllers.dart';

import 'package:heyy/pages/pages.dart';
import 'package:heyy/routing/routes.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget with AppMixin {
  const OTPScreen({Key? key}) : super(key: key);

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
                  Text(
                    "Verification",
                    style: theme.displayTitle1(color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "An OTP will be sent to the number \n ${snc.phoneNo.value} ",
                      textAlign: TextAlign.center,
                      style: theme.displaySubTitle2(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 6,
                      controller: snc.codeController,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Obx(
                      () => Button(
                        text: snc.setupLoader.value ? 'Loading...' : 'Verify',
                        onPressed: () async {
                          if (!snc.setupLoader.value) {
                            snc.setupLoader.value = true;
                            await snc.loginUser().then((value) async {
                              if (value) {
                                if (!await snc.getUser()) {
                                  Navigator.pushNamed(context, Routes.userSetupPage);
                                } else {
                                  Navigator.pushNamed(context, Routes.homePage);
                                }
                              } else {
                                Get.snackbar('Warning', 'Incorrect Otp');
                              }
                            });
                            snc.setupLoader.value = false;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(children: [
                      Expanded(
                        child: Button(
                            text: 'Resend Code',
                            onPressed: () {
                              snc.codeController.clear();
                            }),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Button(
                          text: 'Change No?',
                          onPressed: () {
                            snc.codeController.clear();
                            Navigator.pushNamed(context, Routes.loginPage);
                          },
                        ),
                      ),
                    ]),
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
